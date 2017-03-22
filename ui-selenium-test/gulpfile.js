var gulp = require('gulp');
var mocha = require('gulp-mocha');
var fs = require( "fs" );

const eslint = require('gulp-eslint');

gulp.task('eslint', function () {

  return gulp.src(['src/*.js*', 'tests/specs/*.js*'])

    .pipe(eslint())
    .pipe(eslint.format())
    .pipe(eslint.format('html', fs.createWriteStream('eslintOutput.html')))
    .pipe(eslint.failAfterError());

});

gulp.task('selenium', function () {

  return gulp.src(['tests/specs/*.js'], { read: false })
    .pipe(mocha({
      reporter: 'spec'
    }))
    .on('error', function() { 
      console.log( 'failed test' ); 
      process.exit.bind(process, 1) 
    });

});


gulp.task('default', ['eslint', 'selenium'], function () {
    // This will only run if the eslint task is successful...
    console.log( 'Success?' );
});

