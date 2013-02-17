=begin rdoc

= KB2.RB

*Author*::      Tamara Temple <tamara@tamaratemple.com>
*Since*::       2013-02-17
*Copyright*::   (c) 2013 Tamara Temple Web Development
*License*::     MIT
  
=end

 
require 'sinatra'
require 'haml'
require 'json'
require './kittens.rb'
kittens = Dir.chdir('public') {|cwd| Kittens.new('kittens')}

get '/' , :provides => :html do
  haml :index
end

get '/next', :provides => :json do
  kittens.next_random.to_json
end

