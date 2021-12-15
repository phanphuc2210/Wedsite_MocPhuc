const jwt = require('jsonwebtoken')
const { connect, sql } = require('../../config/db')


class MeController {
    
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

        } catch (error) {// Nếu chưa đăng nhập thì render ra home
            res.render('login')
        }
    }

    //[GET] /me/info
    info(req, res, next) {
        res.render('me/info', {
            customer: req.data
        })
    }

    //[GET] /me/edit
    edit(req, res, next) {
        res.render('me/edit', {
            customer: req.data
        })
    }

    //[PUT] /me/edit
    async update(req, res, next) {
        //update from khachhang set .....
        var pool = await connect
        var sqlString = `update khachhang set
                        ho=@ho,tendem=@tendem,ten=@ten,ngaysinh=@ngaysinh,
                        diachi=@diachi,sdt=@sdt,email=@email
                        where idkh=@idkh
                        `
        return await pool.request()
                        .input('idkh', sql.Int, req.body.idkh)
                        .input('ho', sql.NVarChar, req.body.ho)
                        .input('tendem', sql.NVarChar, req.body.tendem)
                        .input('ten', sql.NVarChar, req.body.ten)
                        .input('ngaysinh', sql.Date, req.body.ngaysinh)
                        .input('diachi', sql.NVarChar, req.body.diachi)
                        .input('sdt', sql.VarChar, req.body.sdt)
                        .input('email', sql.NVarChar, req.body.email)
                        .query(sqlString)
                        .then(() => 
                            res.redirect('/me/info'))
                        .catch(err => {

                        })
    }

    //[GET] /me/cart
    async cart(req, res, next) {
        var pool = await connect
        return await pool.request()
                        .input('idkh', sql.Int, req.data.IDKH)
                        .execute('SP_XEMGIOHANG')
                        .then(cart => //res.json(cart)
                            res.render('me/cart', {
                                cart: cart.recordsets[0],
                                totalPrice: cart.recordsets[1][0],
                                customer: req.data
                            })
                        )
    }

    //[POST] /me/addCart
    async addCart(req, res, next) {
        //exec SP_THEMGIOHANG .....
        var pool = await connect
        return await pool.request()
                        .input('idkh', sql.Int, req.data.IDKH)
                        .input('idsp', sql.Int, req.body.idsp)
                        .input('soluong', sql.Int, req.body.soluong)
                        .execute('SP_THEMGIOHANG')
                        .then(() => {
                            res.json('Đã thêm vào giỏ hàng')
                        })
                        .catch(err => {
                            console.log(err)
                        })
    }

    //[DELETE] /me/cart/:idsp
    async destroy(req, res, next) {
        //delete giohang where idkh = @idkh and idsp = @idsp
        var pool = await connect
        var sqlString = `delete giohang where idkh = @idkh and idsp = @idsp`
        return await pool.request()
                        .input('idkh', sql.Int, req.data.IDKH)
                        .input('idsp', sql.Int, req.body.idsp)
                        .query(sqlString)
                        .then(() => 
                            res.json({
                                message: 'Xóa thành công'
                            })
                        )
                        .catch(err => {

                        })
    }

     //[POST] me/cart/order
    async order(req, res, next) {
        var pool = await connect
        return await pool.request()
                        .input('idkh', sql.Int, req.data.IDKH)
                        .input('noigiaohang', sql.NVarChar, req.body.noigiao)
                        .execute('SP_THEMHOADON')
                        .then(() => 
                            res.redirect('/me/receipt')
                        )
                        .catch(err => {
                            console.log(err)
                        })
    }

    //[GET] /me/receipt
    async receipt(req, res, next) {
        var pool = await connect
        var sqlString = `select * from HOADON where idkh = @idkh`
        return await pool.request()
                        .input('idkh', sql.Int, req.data.IDKH)
                        .query(sqlString)
                        .then((receipts) => 
                            res.render('me/receipt',{
                                receipts: receipts.recordset,
                                customer: req.data
                            })
                        )
                        .catch(err => {

                        })
    }

    //[GET] /me/receipt/detail
    async detail(req, res, next) {
        var pool = await connect
        return await pool.request()
                        .input('idhd', sql.Int, req.query.idhd)
                        .execute('SP_XEMHOADON')
                        .then((detail) => //res.json(detail)
                            res.render('me/detail',{
                                idhd: req.query.idhd,
                                detail: detail.recordsets[0],
                                totalPrice: detail.recordsets[1][0],
                                customer: req.data
                            })
                        )
                        .catch(err => {

                        })
    }
}

module.exports = new MeController