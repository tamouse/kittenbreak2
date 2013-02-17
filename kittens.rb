=begin rdoc

= KITTENS.RB

*Author*::      Tamara Temple <tamara@tamaratemple.com>
*Since*::       2013-02-17
*Copyright*::   (c) 2013 Tamara Temple Web Development
*License*::     MIT
  
=end

class Kittens

  attr_reader :kittens

  def initialize(path='.')
    raise "Not a directory!" unless File.directory?(path)
    @kittens = Dir.entries(path).each.grep(/(jpe?g|png|gif)/i).map{|f| File.join(path,f)}
  end

  def next_random
    @kittens[rand(@kittens.count)]
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
