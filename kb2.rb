=begin rdoc

= KB2.RB

*Author*::      Tamara Temple <tamara@tamaratemple.com>
*Since*::       2013-02-17
*Copyright*::   (c) 2013 Tamara Temple Web Development
*License*::     MIT
  
=end

require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'json'
require './kittens.rb'

class KittenBreak < Sinatra::Base


  kittens = Dir.chdir('public') {|cwd| Kittens.new('kittens')}

  get '/' , :provides => :html do
    haml :index
  end

  get '/next', :provides => :json do
    kittens.next_random.to_json
  end

  get '/reload' do
    Dir.chdir('public') {|cwd| kittens.reload }
    redirect to('/')
  end

end
