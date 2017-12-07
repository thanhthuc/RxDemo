/**
 * Created by tranvanthanh on 3/14/17.
 */
var fs = require('fs');
var configFilePath = __dirname + "/config.json";

exports.config = JSON.parse(fs.readFileSync(configFilePath));