var should = chai.should();

describe("Application", function() {
    it("creates a global variable for the name sapce", function() {
	should.exist(kittenApp);
    })
})


describe("Kitten Model", function() {
    describe("Initialization", function() {
	beforeEach(function() {
	    this.kitten = new kittenApp.Kitten();
	})
	it("should have an empty image link", function() {
	    this.kitten.get('source').should.equal("");
	})
    })
})

describe("Kitten View", function() {
    beforeEach(function() {
	//this.kitten = new kittenApp.Kitten({source: "http://www.wallsave.com/wallpapers/2560x2048/anime-kittens/496315/anime-kittens-cats-praying-496315.jpg"}); 
	this.kitten = new kittenApp.Kitten({source: "kitten.jpg"}); 
	this.kittenView = new kittenApp.KittenView({model: this.kitten});
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
	    this.kittenView.$el.attr("id").should.equal("kitten_container");
	})
    })
})

