/**********************************************************************************************************
 * 
 *  Selenium locator functions...
 * 
 *   webdriver.by.className('.my-class')
 *   webdriver.by.css('#some-id')
 *   webdriver.by.id('element-id')
 *   webdriver.by.linkText('click me')
 *   webdriver.by.js
 *   webdriver.by.name('firstName')
 *   webdriver.by.partialLinkText('click')
 *   webdriver.by.tagName('a')
 *   webdriver.by.xpath()
 * 
 *  Mocha note:
 *    To run a single test... ./node_modules/.bin/mocha -g Search test/YOURTEST.js
 * 
 *    -g Pattern matches the 'describe'
 *
 */
'use strict';
require('chai').should();

var expect = require('chai').expect,
    config = require('./../../src/config'),
    browser = config.browser(
        'firefox', 
        !process.env['http_proxy'] ? '' : process.env['http_proxy'], 
        !process.env['https_proxy'] ? '' : process.env['https_proxy']
    );

var webdriver = browser.webdriver,
    By        = browser.by,
    until     = browser.until,
    driver    = browser.driver;

config.signTestFile(__filename);

/**
 * Landing page.  Ensure title is correct.
 */
describe('Google Test', function () {

    /* 10 Seconds works well locally */
    this.timeout(browser.timeout);

    /**
     * Before hook to start webdriver
     */
    before(function (done) {
       
        driver.navigate().to('http://google.com/')
            .then(() => done())
    });

    /**
     * Page title correct?
     */
    it('Ensure page Google title is correct', function (done) {
        driver.getTitle()
            .then(() => driver.getTitle())
            .then(title => title.should.equal('Google'))
            .then(() => done());
    });


    /**
     * After hook to quit webdriver
     */
    after(function (done) {
        driver.quit()
            .then(() => done());

    });
});