=begin rdoc

= KITTENS.RB

*Author*::      Tamara Temple <tamara@tamaratemple.com>
*Since*::       2013-02-17
*Copyright*::   (c) 2013 Tamara Temple Web Development
*License*::     MIT
  
=end

class Kittens

  attr_reader :kittens
  attr_accessor :path

  def initialize(path='.')
    raise "Not a directory!" unless File.directory?(path)
    self.path = path
    reload
  end

  def next_random
    @kittens[rand(@kittens.count)]
  end

  def reload
    @kittens = Dir.entries(path).each.grep(/(jpe?g|png|gif)/i).map{|f| File.join(path,f)}
  end

  include Enumerable

  def each &block

    @kittens.each do |kitten|
      if block_given?
        block.call kitten
      else
        yield kitten
      end
      
    end
    
  end

  


end 
