
/**
var data = require('./records.json'),
    arr = [];

console.log(data);
arr.push('<booking>');
arr.push('  <accountsDetails>');
for (var k in data) {
    arr.push('    <'+k+' type="'+(typeof data[k])+'">'+data[k]+'</'+k+'>');
}
arr.push('  </accountsDetails>');
arr.push('</booking>');

console.log(arr.join('\n'));
 */

var fs = require('fs'),
    JSONPath = require('JSONPath'),
    apiResponse = require('./response.json'),
    xpath = require('xpath'),
    dom = require('xmldom').DOMParser,
    xmlString = fs.readFileSync('./myrecord.xml').toString(),
    xmlDbRecord = new dom().parseFromString(xmlString);

console.log(xpath.select("//booking//accountsDetails/site_no", xmlDbRecord)[0]);
console.log(''+JSONPath({path: '$..booking.details.hotel.site_no', json: apiResponse }));

