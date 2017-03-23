'use strict';

var i = 0, _instances = {},
    path = require('path'),
    fs = require('fs'),
    md5 = require('md5');

module.exports = {
    browser: function () {
        ++i;
        var webdriver = require('selenium-webdriver'),
            By = webdriver.By,
            until = webdriver.until,
            proxy = require('selenium-webdriver/proxy'),
            driver = new webdriver.Builder()
            .withCapabilities({ 'browserName': 'firefox' })
            .setProxy(proxy.manual({
                http: 'proxy.scee.net:3128',
                https: 'proxy.scee.net:3128'
            })).build();

        return {
            webdriver: webdriver,
            By: By,
            until: until,
            proxy: proxy,
            webdriver: webdriver,
            driver: driver
        };
    },
    signFile: function (file) {
        console.log( 'MD5: ' + md5(fs.readFileSync(file)) + ' File: ' + path.basename(file) );
    }
};
