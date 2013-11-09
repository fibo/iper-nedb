
module.exports = (grunt) ->
  grunt.initConfig
    watch:
      mochacli:
        files: ['index.js', 'spec.coffee']
        tasks: 'mochacli'
    mochacli:
      options:
        require: ['coffee-script', 'should']
        reporter: 'spec'
        bail: true
      all: ['index.js', 'spec.coffee']

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-mocha-cli'

  grunt.registerTask 'default', ['watch']

