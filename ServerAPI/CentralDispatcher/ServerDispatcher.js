/**
 * Created by tranvanthanh on 2/27/17.
 */
'use strict';

const url = require('url');
const db = require('../DBManager/DBManager');

//express
const express = require('express');
const router = express.Router();
var bodyParser = require('body-parser');
var multer = require('multer'); // v1.0.5
var upload = multer();

router.use(bodyParser.json());
router.use(bodyParser.urlencoded({ extended: true }));
module.exports = router;
router.post('/login', function (req, res) {
    try {
        let username = req.body.username;
        let password = req.body.password;

        let responseObject;
        if (username === "thanhxxx" && password === "12345678") {
            responseObject = {
                statusCode: 1,
                message: "OK",
                user: {
                    username: "thanhxxx",
                    userId: "2",
                    userDisplayName: "Thanh So Ciu"
                }
            }
        } else {
            responseObject = {
                message: "wrong username or password",
                statusCode: 2
            }
        }
        console.log("response: " + responseObject);
        return res.status(200).json(responseObject);
    } catch (err) {
        console.log("ERROR: " + err);
        return res.status(400).json({
            status: "error",
            error: err
        });
    }
});

router.post('/register', function (req, res) {
    try {
        let username = req.body.username;
        let responseObject;

        if (username === "thanhxxx") {
            responseObject = {
                message: "username is already registered",
                statusCode: 2
            }
        } else {
            responseObject = {
                message: "register successfully",
                statusCode: 1
            }
        }
        console.log("response: " + responseObject.message);
        return res.status(200).json(responseObject);

    } catch (err) {
        console.log("ERROR: " + err);
        return res.status(400).json({
            status: "error",
            error: err
        });
    }
});

router.get('/listProduct', function (req, res) {
    try {
        let from = 1;
        let to = 100;

        db.getListProduct(from, to, (rows, error) => {
            let productsArray = [];
            if (rows.length <= 0) {

            } else {
                for (let i = 0; i < rows.length; i++) {
                    productsArray[i] = {
                        productId: rows[i].productId,
                        addressName: rows[i].addressName,
                        productName: rows[i].productName,
                        productImageUrl: rows[i].productImageUrl,
                        productPrice: rows[i].productPrice
                    }
                }
            }
            return res.status(200).json({
                statusCode: 1,
                message: "get list product successfully",
                products: productsArray
            });
        });

    } catch (err) {
        console.log("ERROR: " + err);
        return res.status(400).json({
            status: "error",
            error: err
        });
    }
});

router.post('/productDetail', upload.array() , function (req, res) {
    try {
        let productId = req.body.productId;
        console.log(req.body.productId);
        db.getProductDetail(productId, (rows, error) => {
            if (rows.length === 0) {
                return res.status(200).json({
                    statusCode: 2,
                    message: "OK",
                    products: []
                })
            }

            let product = {
                productId: rows[0].productId,
                addressName: rows[0].addressName,
                productName: rows[0].productName,
                productImageUrl: rows[0].thumbpath,
                districtName: rows[0].districtName,
                latitude: rows[0].latitude,
                longitude: rows[0].longitude,
                rating: rows[0].rate,
                restaurantName: rows[0].restaurantName,
                urlrelate: rows[0].urlrelate
            };
            return res.status(200).json(product);

        });

    } catch (err) {
        console.log("ERROR: " + err);
        return res.status(400).json({
            status: "error",
            error: err
        });
    }
});

router.post('/checkout', function (req, res) {
    let body = req.body;
    let receipt = {
        receiptName: body.receiptName,
        datetime: body.datetime,
        product: body.product,
        priceTotal: body.priceTotal,
        method: body.method,
        currencyUnit: body.currencyUnit,
        userId: body.userId
    };

    db.saveNewReceipt(receipt, function (rows, err) {
        if (rows.length === 0) {
            return res.status(200).json({
                statusCode: 2,
                message: "Error: " + err,
            });
        }

        return res.status(200).json({
            statusCode: 1,
            message: "Check out successfully",
        });
    })
});


router.post('/', function (req, res) {
    try {
        return res.status(200).json({
            status: "ok"
        });
    } catch (err) {
        console.log("ERROR: " + err);
        return res.status(400).json({
            status: "error",
            error: err
        });
    }
});







