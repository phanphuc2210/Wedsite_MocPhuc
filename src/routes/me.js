const express = require('express')
const router = express.Router()
const meController = require('../app/controllers/MeController')


router.get('/receipt/detail', meController.checkLogin, meController.detail)
router.get('/receipt', meController.checkLogin, meController.receipt)
router.get('/cart', meController.checkLogin, meController.cart)
router.post('/cart/order', meController.checkLogin, meController.order)
router.delete('/cart/:idsp', meController.checkLogin, meController.destroy)
router.post('/addCart', meController.checkLogin, meController.addCart)
router.get('/edit', meController.checkLogin, meController.edit)
router.put('/edit', meController.update)
router.get('/info', meController.checkLogin, meController.info)


module.exports = router