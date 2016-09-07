gulp = require 'gulp'
runSequence = require 'run-sequence'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
watch = require 'gulp-watch'

gulp.task 'js', ->
  gulp.src './src/*.coffee'
    .pipe coffee({bare: true})
    .pipe uglify()
    .pipe gulp.dest('./extension/')

gulp.task 'default', (callback) ->
  runSequence(
    [ 'js']
    callback
  )

gulp.task 'watch', ->
  gulp.watch(
    './src/*.coffee'
    ['js']
  )

gulp.task 'release', ->
  gulp.src './src/*.coffee'
    .pipe coffee()
    .pipe uglify()
    .pipe gulp.dest('./extension/')
