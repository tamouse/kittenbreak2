/*
 * Define our dependencies explicitly so we can run
 * tests either in the browser or via node.js command
 * line without having to add AMD support for the
 * browser version.
 *
 * The statements below are only required for node.js
 * testing (since node.js isn't as permissive with
 * respect to global variables). They don't do any
 * harm in the browser, though.
 */

var jQuery   = jQuery   || require("jquery");
var _        = _        || require("underscore");
var Backbone = Backbone || require("backbone");
Backbone.$   = jQuery;



var Kitten = Backbone.Model.extend({
    defaults: {
	source: ""
    },
    url: "/next"
});

var KittenView = Backbone.View.extend({
    //tagName: "div",
    //id: "kitten_container",
    el: '#kitten_container',
    template: _.template(
	"<img class='kitten_image' src='<%= source %>' alt='another kitten for you' title='click to get another kitten'>"
    ),
    render: function() {
	this.$el.html(this.template(this.model.attributes));
	return this;
    }
});
