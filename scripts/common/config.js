var require = {
	baseUrl: "/scripts",
	deps: [ "cs!common/loadOnStart" ],
	paths: {
		//RequireJS Plugins
		cs: "lib/require/plugins/cs",
		text: "lib/require/plugins/text",
		//Js Libs
		jquery: "lib/jquery/jquery-1.7.2.min",
		underscore: "lib/underscore/underscore-1.3.1",
		backbone: "lib/backbone/backbone-0.9.2",
		marionette: "lib/marionette/marionette-0.7.0",
		//JQuery Libs
		prettify: "lib/prettify/prettify",
		bootstrap: "lib/bootstrap/bootstrap"
	},
	shim: {
		jquery: { exports: "$" },
		underscore: { exports: "_" },
		prettify: ["jquery"],
		bootstrap: ["jquery"],
		backbone: {
			deps: ["underscore","jquery"],
			exports: "Backbone"
		},
		marionette: {
			deps: ["backbone"],
			exports: "Backbone.Marionette"
		}
	}
};
