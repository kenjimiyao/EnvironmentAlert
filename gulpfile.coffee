gulp = require 'gulp'
runSequence = require 'run-sequence'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
plumber = require 'gulp-plumber'
watch = require 'gulp-watch'
zip = require 'gulp-zip'

gulp.task 'js', ->
  gulp.src './src/*.coffee'
    .pipe coffee({bare: true})
    .pipe uglify()
    .pipe gulp.dest('./extension/')

gulp.task 'resources', ->
  gulp.src ['./src/*.json', './src/**/*.png', './src/**/*.html']
    .pipe gulp.dest('./extension/')

gulp.task 'default', (callback) ->
  runSequence(
    [ 'js', 'resources' ]
    callback
  )

gulp.task 'watch', ->
  gulp.watch(
    './src/**/*'
    ['default']
  )

gulp.task 'pack', ->
  target = ['**/*.html', '**/*.js', '**/*.css', '**/*.png', '**/*.json']
  gulp.src target, {cwd: 'app'}
  .pipe zip('app.zip')
  .pipe gulp.dest('webstore')

gulp.task 'release', ->
  runSequence(
    'default'
    'pack'
  )
