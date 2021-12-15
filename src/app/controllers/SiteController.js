const jwt = require('jsonwebtoken')
const { connect, sql } = require('../../config/db')

class SiteController {
    
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
            //res.render('home')
            next()
        }
    }

    
    //[GET] /
    index(req, res, next) {
        res.render('home', {
            customer: req.data
        })
    }

    //[GET] /search
    aboutUs(req, res, next) {
        res.render('aboutUS', {
            customer: req.data
        })
    }

    //[GET] /register
    register(req, res, next) {
        res.render('register')
    }

    //[POST] /register
    async create(req, res, next) {
        //exec SP_THEMKHACHHANG .....
        var pool = await connect
        return await pool.request()
                        .input('tendn', sql.VarChar, req.body.tendn)
                        .input('pass', sql.VarChar, req.body.pass)
                        .input('ho', sql.NVarChar, req.body.ho)
                        .input('tendem', sql.NVarChar, req.body.tendem)
                        .input('ten', sql.NVarChar, req.body.ten)
                        .input('ngaysinh', sql.VarChar, req.body.ngaysinh)
                        .input('diachi', sql.NVarChar, req.body.diachi)
                        .input('sdt', sql.VarChar, req.body.sdt)
                        .input('email', sql.NVarChar, req.body.email)
                        .execute('SP_THEMKHACHHANG')
                        .then(() => 
                            res.redirect('/login'))
                        .catch(err => {
                            res.json('Đăng kí thất bại')
                        })
    }

    //[GET] /login
    login(req, res, next) {
        res.render('login')
    }

    //[POST] /login
    async authenticate(req, res, next) {
        //select * from TAIKHOAN where tendn = @tentk and pass = @pass
        var pool = await connect
        var sqlString = `select * from TAIKHOAN where tendn = @tendn and pass = @pass`
        return await pool.request()
                        .input('tendn', sql.VarChar, req.body.tendn)
                        .input('pass', sql.VarChar, req.body.pass)
                        .query(sqlString)
                        .then(account => {
                            if(account.recordset[0]) {
                                var token = jwt.sign({
                                    idtk: account.recordset[0].IDTK
                                }, 'mk')
                                // return res.json({
                                //     message: 'Đăng nhập thành công',
                                //     token: token
                                // })
                                res.cookie('token', token, { expires: new Date(Date.now() + 900000)})
                                res.redirect('/')
                            }
                            else  
                                res.render('login',{
                                    message: "Đăng nhập thất bại. Mời nhập lại."
                                })
                        }     
                        )
                        .catch(err => {
                            console.log(err)
                        })
    }

    

}


module.exports = new SiteController