const path = require('path')
const express = require('express')
const morgan = require('morgan')
const handlebars = require('express-handlebars')
const methodOverride = require('method-override')
const cookieParser = require('cookie-parser')
const app = express()
const port = 3000

const route = require('./routes')

app.use(express.static(path.join(__dirname,'public')))

// HTTP logger
app.use(morgan('combined'))

// Template engine
app.engine('hbs', handlebars({
  extname: '.hbs'
}))
app.set('view engine', 'hbs')
app.set('views', path.join(__dirname, 'resources', 'views'))

app.use(express.urlencoded({extended:true}))
app.use(express.json())

// method override
// override with POST having ?_method=DELETE
app.use(methodOverride('_method'))

app.use(cookieParser())

// Routes init
route(app)




app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`)
})