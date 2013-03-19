=begin rdoc

= KITTENS.RB

*Author*::      Tamara Temple <tamara@tamaratemple.com>
*Since*::       2013-02-17
*Copyright*::   (c) 2013 Tamara Temple Web Development
*License*::     MIT
  
=end

class Kittens

  attr_accessor :path

  def initialize(path='.')
    self.path=path
    self.kittens
  end

  def path=(path='.')
    raise "Not a directory!" unless File.directory?(path)
    @path=path
  end

  def kittens
    @kittens ||= reload(self.path)
  end

  def next_random
    @kittens ||= reload()
    @kittens[rand(@kittens.count)]
  end

  def reload(path=nil)
    self.path=path unless path.nil?
    @kittens = Dir.entries(self.path).each.grep(/(jpe?g|png|gif)/i).map{|f| File.join(self.path,f)}
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
