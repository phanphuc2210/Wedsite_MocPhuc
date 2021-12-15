const productRouter = require('./product')
const siteRouter = require('./site')
const meRouter = require('./me')

function route(app) {

    app.use('/me', meRouter)    

    app.use('/products', productRouter)

    app.use('/', siteRouter)
}

module.exports = route
