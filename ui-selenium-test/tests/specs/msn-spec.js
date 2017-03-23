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
    testConfig = require('./../../src/config');

testConfig.signFile(__filename);

/**
 * Landing page.  Ensure title is correct.
 */
describe('MSN Test', function () {

    /* 10 Seconds works well locally */
    this.timeout(10000);

    /**
     * Before hook to start webdriver
     */
    before(function (done) {
       
        testConfig.driver.navigate().to('http://www.msn.com/en-gb/')
            .then(() => done())
    });

    /**
     * Page title correct?
     */
    it('Ensure page title is correct', function (done) {
        testConfig.driver.getTitle()
            .then(() => testConfig.driver.getTitle())
            .then(title => title.should.equal('MSN UK | Latest news, Hotmail sign in, Outlook email, Skype, live scores'))
            .then(() => done());
    });


    /**
     * After hook to quit webdriver
     */
    after(function (done) {
        testConfig.driver.quit()
            .then(() => done());

    });
});