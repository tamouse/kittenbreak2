// following needed to run tests directly under mocha and node.js
// headless for CI/T

if (typeof exports !== 'undefined' && this.exports !== exports) {
  global.jQuery = require("jquery");
  global.$ = jQuery;
  global.chai = require("chai");
  global.sinon = require("sinon");
  chai.use(require("sinon-chai"));
  global.jsdom = require("jsdom").jsdom;
  var doc = jsdom("<html><body></body></html>");
  global.window = doc.createWindow();
}

var should = chai.should();

var placekitten = 'http://placekitten.com/300/300';

describe("Kitten Model", function() {
    describe("Initialization", function() {
	beforeEach(function() {
	    this.kitten = new Kitten();
	})
	it("should have an empty image link", function() {
	    this.kitten.get('source').should.equal("");
	})
	it("should emulate fetching a kitten image", function() {
	    this.ajax_stub = sinon.stub($, "ajax").yieldsTo("success",
							    { "source": placekitten }
							   );
	    this.kitten.fetch();
	    this.kitten.get("source").should.equal(placekitten);
	    this.ajax_stub.restore();
	})
    })
})

describe("Kitten View", function() {
    beforeEach(function() {
	this.kitten = new Kitten({source: placekitten }); 
	this.kittenView = new KittenView({model: this.kitten});
	$("<div>").attr("id","kitten_container").appendTo("body");
    })
    it("render() should return the view object", function() {
	this.kittenView.render().should.equal(this.kittenView);
    })
    it("should render as an image", function() {
	this.kittenView.render().el.nodeName.should.equal("DIV");
    })
    describe("Template", function() {
	beforeEach(function() {
	    this.kittenView.render();
	})
	it("should have a source URL", function() {
	    this.kittenView.$el.find("img").attr("src").should.equal(placekitten);
	})
	it("should have a class of 'kitten_image'", function() {
	    this.kittenView.$el.find("img").attr("class").should.equal("kitten_image");
	})

	it("should have an id of 'kitten_container'", function() {
	    this.kittenView.el.id.should.equal("kitten_container");
	})
    })
})

