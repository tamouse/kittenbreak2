var should = chai.should();

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
							    { "source": "kitten.jpg"}
							   );
	    this.kitten.fetch();
	    this.kitten.get("source").should.equal("kitten.jpg");
	    this.ajax_stub.restore();
	})
    })
})

describe("Kitten View", function() {
    beforeEach(function() {
	//this.kitten = new kittenApp.Kitten({source: "http://www.wallsave.com/wallpapers/2560x2048/anime-kittens/496315/anime-kittens-cats-praying-496315.jpg"}); 
	this.kitten = new Kitten({source: "kitten.jpg"}); 
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
	    this.kittenView.$el.find("img").attr("src").should.equal("kitten.jpg");
	})
	it("should have a class of 'kitten_image'", function() {
	    this.kittenView.$el.find("img").attr("class").should.equal("kitten_image");
	})

	it("should have an id of 'kitten_container'", function() {
	    this.kittenView.el.id.should.equal("kitten_container");
	})
    })
})

