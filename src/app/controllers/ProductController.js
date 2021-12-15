const jwt = require('jsonwebtoken')
const { connect, sql } = require('../../config/db')

class ProductController {

     // hàm kiểm tra đã đăng nhập chưa
     async checkLogin(req, res, next) {
        try {
            var token = req.cookies.token
            var result = jwt.verify(token, 'mk')

            //select * from taikhoan where idtk = @idtk
            var pool = await connect
            var sqlString = `select * from khachhang where idtk = @idtk`
            var customer = await pool.request()
                        .input('idtk', sql.Int, result.idtk)
                        .query(sqlString)

            if(customer){
                req.data = customer.recordset[0]
            }
            next()

        }
        catch (error) {// Nếu chưa đăng nhập thì render ra home
             //res.render('login')
             next()
        }
    }

    // hàm kiểm tra đã đăng nhập chưa
    async checkLoginComment(req, res, next) {
        try {
            var token = req.cookies.token
            var result = jwt.verify(token, 'mk')

            //select * from taikhoan where idtk = @idtk
            var pool = await connect
            var sqlString = `select * from khachhang where idtk = @idtk`
            var customer = await pool.request()
                        .input('idtk', sql.Int, result.idtk)
                        .query(sqlString)

            if(customer){
                req.data = customer.recordset[0]
            }
            next()

        }
        catch (error) {// Nếu chưa đăng nhập thì render ra home
             res.render('login')
        }
    }

    //[GET] /product/:idlsp
    async index(req, res) {
        //select * from sanpham
        var pool = await connect
        var sqlString = `select * from sanpham where idlsp = @idlsp`
        return await pool.request()
                        .input('idlsp', sql.Int, req.params.idlsp)
                        .query(sqlString)
                        .then(products => 
                            res.render('products/products',{
                                products: products.recordset,
                                customer: req.data
                            }))
    }

    //[GET] /product/:idlsp/:idsp
    async show(req, res) {
        var pool = await connect
        return await pool.request()
                        .input('idsp', sql.Int, req.params.idsp)
                        .execute('SP_XEMSP')
                        .then(product => //res.json(product)
                            res.render('products/show', {
                                product : product.recordsets[0][0],
                                comments: product.recordsets[1],
                                customer: req.data
                            })
                        )
    }

    //[POST] /product/:idlsp/:idsp
    async comment(req, res) {
        //insert into BINHLUAN(IDKH,IDSP,NOIDUNGBL) values
        //(1,1,N'Mọi người nên mua dùng thử nhé !!!') 
        var pool = await connect
        var sqlString = `insert into BINHLUAN(IDKH,IDSP,NOIDUNGBL) values
                        (@idkh,@idsp,@noidungbl)`
        return await pool.request()
                        .input('idkh', sql.Int, req.data.IDKH)
                        .input('idsp', sql.Int, req.params.idsp)
                        .input('noidungbl', sql.NVarChar, req.body.noidungbl)
                        .query(sqlString)
                        .then(() => {
                            res.redirect('back')
                        })
                        .catch(err => {
                            console.log(err)
                        })
    }
 
}

module.exports = new ProductController