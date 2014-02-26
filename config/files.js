/* Exports a function which returns an object that overrides the default &
 *   plugin file patterns (used widely through the app configuration)
 *
 * To see the default definitions for Lineman's file paths and globs, see:
 *
 *   - https://github.com/linemanjs/lineman/blob/master/config/files.coffee
 */
module.exports = function(lineman) {
  //Override file patterns here
  return {

    // As an example, to override the file patterns for
    // the order in which to load third party JS libs:
    //
    coffee: {
	    app: [
    	 	"app/js/main.coffee",
    	 	"app/js/services/**/*.coffee",
    	 	"app/js/**/*.coffee"
    	]
    },
    js: {
    	vendor: [
    	    "vendor/underscore/underscore.js",
			"vendor/bower/angular/angular.js",
			"vendor/js/**/*.js"  //Note that this glob remains for traditional vendor libs
		],
		specHelpers: [
		    "vendor/bower/angular-mocks/angular-mocks.js",
			"spec/helpers/**/*.js"
		]
    }
    
  };
};
