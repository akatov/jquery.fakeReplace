# global module:false

module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    meta:
      src: 'src'
      test: 'test'
    clean: target: src: ['<%= pkg.title %>.js']
    coffeelint:
      src:
        files: src: ['<%= meta.src %>/**/*.coffee']
        options: max_line_length: level: 'warn'
      test:
        files: src: ['<%= meta.src %>/**/*.coffee']
        options: max_line_length: level: 'warn'
      gruntfile: files: src: ['Gruntfile.coffee']
    coffee: src:
      files: '<%= pkg.name %>.js': ['<%= meta.src %>/**/*.coffee']
      options: bare: true
    jshint: target: ['<%= pkg.name %>.js']

  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  grunt.registerTask 'lint', ['coffeelint']
  grunt.registerTask 'build', ['clean', 'coffee']
  grunt.registerTask 'default', ['lint' , 'build', 'jshint']
