# Development notes

With the backbone version of KB2, we need to have a full continuous
development/testing platform in place. For this, I've chosen to follow
the advice given in [Unit Testing
Backbone](http://www.sitepoint.com/unit-testing-backbone-js-applications/)
and use [node.js](http://nodejs.org) along with the following
components:

* [Test'em](https://github.com/airportyh/testem) - provides a
  continuous test environment
* [Mocha](http://visionmedia.github.com/mocha/) - testing framework
* [Chai Assertion Library](http://chaijs.com/) - a good assertion
  library for our tests
* [Sinon Mocks](http://sinonjs.org/) - mocks, stubs, spies, etc

## Acquiring the testing environment:

1. Install node.js

2. Install the tools

    a. Global installation:

            $ npm install -g jquery jsdom underscore backbone mocha chai sinon sinon-chai testem

    b. Local installation is similar, just drop the `-g`:

            $ npm install jquery jsdom underscore backbone mocha chai sinon sinon-chai testem

## Running tests

*Test'em* basically does it all. At a free terminal prompt, enter:

        $ testem

This will start up the testem runner, and you can open a browser
window to the url given to provide a place to receive the tests.

## Rake tasks

Two rake tasks at present:

        rake ci      # Run tests in CI mode
        rake testem  # Start testem driver

Just running

        $ rake

runs `rake testem` and launches a browser to receive the tests.


## NODE_PATH for Global `npm` modules

According to [this question on stackoverflow](http://stackoverflow.com/questions/15636367/nodejs-require-a-global-module-package),
`node.js` won't normally load global modules unless you tell it where
they are kept. `Testem` doesn't seem to have a problem with this, so
TDD and continuous testing are fine. However, to switch over to CI
testing running `mocha` directly means you have to do the following:

        $ NODE_PATH=/usr/lib/share/npm/lib/node_modules mocha

to get the tests to run. (Substitute your system's path to the global
node_modules. The above is how things are set up via `brew install
node` on the mac.)

> Note that currently this doesn't quite work yet. I haven't figured
  out how to load the application before the tests run.

