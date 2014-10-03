# Load all required libraries.
gulp       = require 'gulp'
$          = require('gulp-load-plugins')({camelize: true})
#jade       = require 'gulp-jade'
#uglify     = require 'gulp-uglify'
#gutil      = require 'gulp-util'
#plumber    = require 'gulp-plumber'
#coffee     = require 'gulp-coffee'

onError = (err) ->
    $.util.log($.util.colors.green(err))

gulp.task 'uglifyjs', ->
    return gulp.src([
        './bower_components/jquery/dist/*.js'
        './bower_components/bootstrap/dist/*.js'
        './compiled/*.js'
    ]).pipe($.plumber({
        errorHandler: onError
    })).pipe($.uglify('app.js', {
        compress: false
    })).pipe(gulp.dest('./public/'))


gulp.task 'coffee', ->
    return gulp.src('./scripts/*.coffee')
        .pipe($.coffee())
        .pipe(gulp.dest('./compiled/'))

# Create your CSS from Sass, Autoprexif it to target 99%
#  of web browsers, minifies it.
#gulp.task 'css', ->
#  gulp.src 'app/css/index.sass'
#    .pipe sass()
#    .pipe prefix "> 1%"
#    .pipe cssmin keepSpecialComments: 0
#    .pipe gulp.dest 'www/css'

# Create you HTML from Jade, Adds an additional step of
#  minification for filters (like markdown) that are not
#  minified by Jade.
gulp.task 'html', ->
  gulp.src 'app/index.jade'
    .pipe $.jade()
#    .pipe minifyHTML()
    .pipe gulp.dest 'www'

# Minify your SVG.
#gulp.task 'svg', ->
#  gulp.src 'app/img/*.svg'
#    .pipe svgmin()
#    .pipe gulp.dest 'www/img'

# Copy the fonts using streams.
gulp.task 'copy', ->
  gulp.src 'bower_components/bootstrap/dist/**/*'
    .pipe($.newer('./public/bootstrap/'))
    .pipe gulp.dest './public/bootstrap/'

  gulp.src 'bower_components/jquery/dist/**/*'
    .pipe($.newer('./public/jquery/'))
    .pipe gulp.dest './public/jquery/'

# Default task call every tasks created so far.
#gulp.task 'default', ['css', 'html', 'svg', 'copy']
gulp.task 'default', ['html', 'copy']
