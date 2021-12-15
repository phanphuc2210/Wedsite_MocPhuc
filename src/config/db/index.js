const sql = require('mssql/msnodesqlv8')

const config = {
    server: "localhost",
    user: "sa",
    password: "221001",
    database: "MOCPHUC",
    driver: "msnodesqlv8"
}

const connect = new sql.ConnectionPool(config)
                .connect()
                .then(pool => pool)

module.exports = { connect, sql }