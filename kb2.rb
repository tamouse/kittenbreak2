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
require './genres.rb'
require './kittens.rb'

class KittenBreak < Sinatra::Base

  enable :sessions, :logging

  genres = Genres.new

  genre = genres.first

  kittens = Kittens.new("public/#{genre}")
  
  get '/' , :provides => :html do
    haml :index, :locals => {:genre => genre, :genres => genres.genres, :wait_icon => 'icons/please_wait.gif'}
  end

  get '/next', :provides => :json do
    kittens.next_random.sub(%r{^.*/public/},'').to_json
  end

  get '/reload' do
    kittens.reload
    redirect to('/')
  end

  get %r{/(\w+)} do |w|
    if genres.genres.include?(w)
      genre = w
      kittens = Kittens.new("public/#{genre}")
      redirect to('/')
    else
      "Unknown genre"
    end
  end

end
