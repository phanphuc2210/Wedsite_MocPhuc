const express = require('express')
const router = express.Router()
const productController = require('../app/controllers/ProductController')

router.get('/:idlsp/:idsp', productController.checkLogin ,productController.show)
router.post('/:idlsp/:idsp', productController.checkLoginComment ,productController.comment)
router.get('/:idlsp',productController.checkLogin, productController.index)


module.exports = router