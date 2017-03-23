'use strict';

let webdriver = require('selenium-webdriver');
let By = webdriver.By;
let until = webdriver.until;

var proxy = require('selenium-webdriver/proxy');
let driver = new webdriver.Builder()
    .withCapabilities({ 'browserName': 'firefox' })
    .setProxy(proxy.manual({
        http: 'proxy.scee.net:3128',
        https: 'proxy.scee.net:3128'
    }))
    .build();

var path = require('path'),
    fs = require('fs'),
    md5 = require('md5');

module.exports = {
    webdriver: webdriver,
    driver: driver,
    signFile: function (file) {
        console.log( 'MD5: ' + md5(fs.readFileSync(file)) + ' File: ' + path.basename(file) );
    }
};
