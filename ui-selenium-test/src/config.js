'use strict';

var i = 0, _instances = {},
    path = require('path'),
    fs = require('fs'),
    md5 = require('md5');

module.exports = {
    browser: function (_browser, _proxyHttp, _proxyHttps) {
        ++i;
        var webdriver = require('selenium-webdriver'),
            By = webdriver.By,
            until = webdriver.until,
            proxy = require('selenium-webdriver/proxy'),
            driver = null;

            if (typeof _proxyHttp === 'string' && typeof _proxyHttps === 'string' 
                && _proxyHttp.length > 8 && _proxyHttps.length > 8) {

                console.log ( '```' );
                console.log('PROXY ON');
                console.log('proxy1: '+_proxyHttp);
                console.log('proxy2: '+_proxyHttps);
                console.log ( '```' );

                driver = new webdriver.Builder()
                    .withCapabilities({ 'browserName': _browser })
                    .setProxy(proxy.manual({
                        http: _proxyHttp,
                        https: _proxyHttps
                    })).build();                
            } else {
                console.log('PROXY OFF');
                driver = new webdriver.Builder()
                    .withCapabilities({ 'browserName': _browser })
                    .build();
            }

        return {
            timeout: 30000,
            webdriver: webdriver,
            By: By,
            until: until,
            proxy: proxy,
            driver: driver
        };
    },
    signTestFile: function (file, configFile) {
        console.log ( '```' );
        console.log( 'MD5:    ' + md5(fs.readFileSync(file)) + ' File: ' + path.basename(file) );
        console.log( 'Config: ' + md5(fs.readFileSync(configFile)) + ' File: ' + path.basename(configFile) );
        console.log ( '```' );
        console.log( '' );
    }
};
