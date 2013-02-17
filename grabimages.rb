=begin rdoc

= GRABIMAGES.RB

Parse the urls from a google images search page and pull over the image.

== Usage:

GrabImages.new url [, filename [, options]]
* create a new object containing the image's url and filename to write it to when fetched.

GrabImages.fetch_image
* fetch the image from the remote imgurl into the local filename

== Info:

*Author*::      Tamara Temple <tamara@tamaratemple.com>
*Since*::       2013-02-17
*Copyright*::   (c) 2013 Tamara Temple Web Development
*License*::     MIT
  
=end

require 'curb'

class GrabImages
  attr_accessor :uri, :imgurl, :filename

  # =initialize(uri, filename, options)
  #
  # == Parameters
  #
  # *uri*:: the uri from the google image page. The value of imgurl= on the query
  # string will be used to set the image url to fetch
  #
  # *filename*:: (Optional) If set, use this instead of the file name derived from
  # image url
  #
  # *options*:: (Optional) Set specific paramters for the instance's operation:
  #     *path*:: the path to prepend to the file name where it will be stored
  #     when fetched.
  #     *resize*:: (boolean)
  #     *width*:: width of image in pixels (default == 300)
  #     *height*:: height of image in pixels (no default, not constrained if nil)
  #
  # == Examples
  #
  #     image = urls.map{|u| GrabImages.new(u,nil,options: "public/images")}
  #
  # gives an array containing GrabImage instances from the urls array,
  # using the filename derived from the image url, and when fetched, the images
  # will be saved in `public/image` directory
  #
  def initialize(uri,filename=nil,options={})
    @options = {
      :path => '.',
      :resize => false,
      :width => 300,
      :height => nil
    }.merge(options)

    raise "Specified :path option must be a directory!" unless File.directory?(@options[:path])

    begin
      self.uri = URI.parse(uri)
    rescue => e
      raise "Must specify valid uri: #{uri}. #{e.class}: #{e.message}"
    end
    
    self.imgurl = extract_imgurl(self.uri.query)
    self.filename = self.clean_filename(filename)
  end


  # = extract_imgurl(query)
  #
  # Extract the image url from the passed in query string
  #
  # == Parameters
  #
  # *query*:: the query string from the original url
  #
  # == Returns
  #
  # (string or nil) the value found on the imgurl= query pqrqmeter
  def extract_imgurl(query)
    return nil if query.nil?

    q_hash = query.split('&').reduce({}) do |h,p|
      (k,v) = p.split('=');h[k]=v;h
    end
    q_hash['imgurl']
  end

  # cleans the filename of extraneious characters
  def clean_filename(filename=nil)
    if filename.nil?
      uparts = URI.parse(self.imgurl)
      filename = File.basename(uparts.path)
    end
    filename.gsub(/(jpe?g|png|gif).*/,'\1')
      .gsub(/^[^[:alnum:]]+/,'')
      .gsub(/[^-_.[:alnum:]]+/,'')
    File.join(@options[:path],filename)
  end


  # fetches the image based upon the imgurl into the filename
  def fetch_image(options={})
    @options.merge(options)
    
    # from Curb samples

    c = Curl::Easy.new
    c.follow_location = true
    c.url = self.imgurl
    print "#{self.imgurl}: "
    File.open(self.filename, 'wb') do|f|
      c.on_progress {|dl_total, dl_now, ul_total, ul_now| print "="; true }
      c.on_body {|data| f << data; data.size }
      c.perform
      puts "=> '#{self.filename}'"
    end    

    resize_image(@options[:width],@options[:height]) if @options[:resize]

    self

  end

  def resize_image(w,h=nil)
    return if w.nil?
    if h.nil?
      r = "#{w}"
    else
      r = "#{w}x#{h}"
    end

    mogrify = `which mogrify`.chomp
    raise "Must have ImageMagick installed (no mogrify)!" if mogrify.empty?

    result = Kernel.system("#{mogrify} -resize #{r} #{self.filename}")
    unless result
      raise "#{mogrify} failed: #{result} for file #{self.filename}"
    end
        
    self
      
  end


end

