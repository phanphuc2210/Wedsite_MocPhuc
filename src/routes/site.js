const express = require('express')
const router = express.Router()
const siteController = require('../app/controllers/SiteController')

router.get('/register', siteController.register)
router.post('/register', siteController.create)
router.get('/login', siteController.login)
router.post('/login', siteController.authenticate)
router.get('/aboutUs',siteController.checkLogin ,siteController.aboutUs)
router.get('/', siteController.checkLogin,siteController.index)


module.exports = router