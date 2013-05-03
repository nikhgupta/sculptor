#!/usr/bin/env ruby
# encoding: utf-8

require 'yaml'
require 'scrapix'
require 'fileutils'

class GIM < Thor
  desc "simple QUERY [NUM] [SIZE]", "download images from a simple google query"
  def simple(query, num = "40", size = "large")
    query = query.downcase
    @scraper = Scrapix::GoogleImages.new query, {size: size}
    @scraper.total = num
    puts "Searching #{num} '#{size}' images for '#{query}'"
    images = @scraper.find; print "*"
    directory = "#{ENV['HOME']}/.w/Images/Scrapix/Google/#{query}"
    download images, directory
    File.open("#{directory}/scrape.yml", "w") {|f| f.puts images.to_yaml}
    puts "\nDone....."
  end

  desc "wallpapers QUERY [NUM]", "download wallpapers for given keyword"
  def wallpapers(query, num = "40")
    query = query.downcase
    @scraper = Scrapix::GoogleImages.new query, {size: "1280x800"}
    @scraper.total = num
    print "Searching #{num} wallpapers for '#{query}': "
    images = @scraper.find; print "*"
    directory = "#{ENV['HOME']}/.w/Images/Scrapix/Google/wallpapers/#{query}"
    download images, directory
    File.open("#{directory}/scrape.yml", "w") {|f| f.puts images.to_yaml}
    puts "\tDone....."
  end


  private

  def download(images, directory)
    FileUtils.mkdir_p directory
    lists = images.map{|x| x[:url]}

    Dir.chdir directory do
      lists.each_slice(20) do |list|
        `echo '#{list.join("\n")}' | parallel -j 4 wget -qct 3 {} -O {/}`
        print "+"
      end
    end
  end
end
