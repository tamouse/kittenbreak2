# Kittenbreak 2

A redux of the nice kitten break website, which seems to have gone belly up.

## Installation

Install from [Github](https://github.com/tamouse/kittenbreak2):

    $ git clone git://github.com/tamouse/kittenbreak2.git

Collect some images and put them in `public/images`. The `grabimages.rb` script can do some of this for you.

## Configuration

Not much to the configuration. Run `bundle install` to make sure you've got everything you need, then simply run `rackup` to start the application:

    $ rackup -p 4567

You can specify any port with the `rackup` command. 4567 is just the default sinatra port.

## Contributing

* Fork it!
* Make a branch
* Make your changes
* Submit a pull request
* Submit bugs to the github repo issues


## Author

Tamara Temple <tamara@tamaratemple.com>

## TODO

Make this work with different subsets of cute images:

* mice
* puppies
* etc.etc.etc.
