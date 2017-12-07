/**
 * Created by tranvanthanh on 3/14/17.
 */

'use strict';
const mysql = require('mysql');
let config = require('../Utilities/app-config').config;

module.exports = {
    getListProduct: getListProduct,
    getProductDetail: getProductDetail,
    saveNewReceipt: saveNewReceipt,
    registerNewUser: registerNewUser
};


function registerNewUser(user, callback) {
    let sql = "insert into receipt   values "
        + "(" + user.username
        + ", " + user.address
        + ", " + user.email
        + ", " + user.password
        + ", " + user.phone
        + ", " + user.role
        + " )";

    connectToDatabase(sql, function (rows, err) {
        return callback(rows, err)
    })
}

function saveNewReceipt(receipt, callback) {
    let sql = "insert into receipt (receipt_name,date_time,products,price_total,method,currency_unit,userid) values ('" + receipt.receiptName
        + "','" + receipt.datetime
        + "', '" + receipt.product
        + "', '" + receipt.priceTotal
        + "', '" + receipt.method
        + "', '" + receipt.currencyUnit
        + "', '" + receipt.userId
        + "')";
    console.log(sql);
    connectToDatabase(sql, (rows, err) => {
        return callback(rows, err);
    });
}

function getListProduct(from, to, callback) {
    let sql = "select productPrice, productName, addressName, productId, productImageUrl from Product where productId between " + from + " and " + to;

    console.log(sql);

    connectToDatabase(sql, (rows, err) => {
        console.log("Success connect");
        return callback(rows, err);
    });
}

function getProductDetail(productId, callback) {
    let sql = "select * from ProductDetail where productId=" + productId;
    console.log(sql);
    connectToDatabase(sql, (rows, err) => {
        return callback(rows, err);
    });
}

// private api
function connectToDatabase(sql, callback) {
    let connection = mysql.createConnection({
        host: config.DBManager.connection.host,
        user: config.DBManager.connection.user,
        password: config.DBManager.connection.password,
        database: config.DBManager.connection.database,
    });
    connection.connect();
    connection.query(sql, function (err, rows, fields) {
        if (err) return new Error("Error: " + err);
        return callback(rows, err);
    });

    connection.end();
}

//private function
function queryMultipleSQLStatements(sql, callback) {
    let connection = mysql.createConnection({
        host: config.DBManager.connection.host,
        user: config.DBManager.connection.user,
        password: config.DBManager.connection.password,
        database: config.DBManager.connection.database,
        multipleStatements: true
    });
    connection.connect();
    connection.query(sql, function (err, rows, fields) {
        if (err) return new Error("Error: " + err);
        return callback(rows[1], err);

    });

    connection.end();
}
