=begin rdoc

= GENRES.RB

*Author*::      Tamara Temple <tamara@tamaratemple.com>
*Since*::       2013-03-19
*Copyright*::   (c) 2013 Tamara Temple Web Development
*License*::     MIT

Class to handle the various image genres. Genres are determined by the subdirectories
under public, except `css`, `js`
=end

 
class Genres
    
  OMISSIONS = %w{css js icons}

  include Enumerable

  def genres
    @genres ||= reload
  end

  def initialize
    genres
  end

  def reload
    Dir.glob("public/*").map{|f| File.basename(f)}.reject{|f| OMISSIONS.include?(f)}.sort
  end

  def each &block
    @genres.each do |genre|
      if block_given?
        block.call genre
      else
        yield genre
      end
    end
  end

end

