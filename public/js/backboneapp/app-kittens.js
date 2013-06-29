if (typeof kittenApp === "undefined") kittenApp = {};

kittenApp.Kitten = Backbone.Model.extend({
    defaults: {
	source: ""
    }
})

kittenApp.KittenView = Backbone.View.extend({
    tagName: "div",
    id: "kitten_container",
    template: _.template(
	"<img class='kitten_image' src='<%= source %>' alt='another kitten for you' title='click to get another kitten'>"
    ),
    render: function() {
	this.$el.html(this.template(this.model.attributes));
	return this;
    }
})