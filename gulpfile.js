var gulp = require('gulp');
var gutil = require('gulp-util');
var coffee = require('gulp-coffee');

gulp.task('coffee', function() {
  gulp.src('./coffee/*.coffee')
    .pipe(coffee().on('error', gutil.log))
    .pipe(gulp.dest('./Re-Search.safariextension/js/'))
});

gulp.task('watch', ['default'], function() {
  gulp.watch('./coffee/*.coffee', ['coffee']);
});

gulp.task('default', ['coffee']);
