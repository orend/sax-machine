require 'rubygems'
require 'benchmark'
#require 'happymapper'
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'sax-machine')
#require 'rfeedparser'
include Benchmark
benchmark_iterations = 10000

# module Feedzirra
#   class AtomEntry
#     include SAXMachine
#     element :title
#     element :name, :as => :author
#     element "feedburner:origLink", :as => :url
#     element :summary
#     element :content
#     element :published
#   end
#   
#   # Class for parsing Atom feeds
#   class Atom
#     include SAXMachine
#     element :title
#     element :link, :value => :href, :as => :url, :with => {:type => "text/html"}
#     element :link, :value => :href, :as => :feed_url, :with => {:type => "application/atom+xml"}
#     elements :entry, :as => :entries, :class => AtomEntry
#   end
# end
# feed_text = File.read("spec/sax-machine/atom.xml")
# 
# benchmark do |t|
#   t.report("feedzirra") do
#     benchmark_iterations.times {
#       Feedzirra::Atom.new.parse(feed_text)
#     }
#   end
#   
#   t.report("rfeedparser") do
#     benchmark_iterations.times {
#       FeedParser.parse(feed_text)
#     }
#   end
# end

class AtomEntry
  include SAXMachine
  element :title
  element :name, :as => :author
  element :summary  
end
class Atom
  include SAXMachine
  element :title
  elements :entry, :as => :entries, :class => AtomEntry  
end

# class Entry
#   include HappyMapper
#   element :title, String
#   element :name, String
#   element :summary, String
# end
# class Feed
#   include HappyMapper
#   element :title, String
#   has_many :entry, Entry
# end
feed_text = File.read("spec/sax-machine/atom.xml")

# Atom benchmark
# 68c445f76b7645f0883b33cddc0874f9444a4f4c - 10.000 times
# sax-machine 47.690000   1.330000  49.020000 ( 51.774769)
# fdf075962fb73dd8979446a0fbbedff4882cbdbf - 10.000 times
# sax-machine 60.180000   1.500000  61.680000 ( 65.937108)
benchmark do |t|
  t.report("sax-machine") do
    benchmark_iterations.times {
      Atom.new.parse(feed_text)
    }
  end
  
  # t.report("happymapper") do
  #   benchmark_iterations.times {
  #     Feed.parse(feed_text)
  #   }
  # end
end

# xml = File.read("spec/benchmarks/public_timeline.xml")
# class Status
#   include HappyMapper
# 
#   element :text, String
#   element :source, String
# end

# class Statuses
#   include SAXMachine
#   
#   elements :status, {:as => :statuses, :class => Class.new do
#     include SAXMachine
#     element :text
#     element :source
#   end}
# end

# public_timeline.xml
# 68c445f76b7645f0883b33cddc0874f9444a4f4c - 10.000 times
# sax-machine101.680000   2.270000 103.950000 (112.754657)
# fdf075962fb73dd8979446a0fbbedff4882cbdbf - 10.000 times
# sax-machine128.510000   2.600000 131.110000 (136.059850)
# benchmark do |t|
#   # t.report("happy mapper") do
#   #   benchmark_iterations.times {
#   #     Status.parse(xml)
#   #   }
#   # end
#   
#   t.report("sax-machine") do
#     benchmark_iterations.times {
#       Statuses.parse(xml)
#     }
#   end
# end

#xml = File.read("spec/benchmarks/amazon.xml")
# class HItem
#   include HappyMapper
# 
#   tag 'Item' # if you put class in module you need tag
#   element :asin, String, :tag => 'ASIN'
#   element :detail_page_url, String, :tag => 'DetailPageURL'
#   element :manufacturer, String, :tag => 'Manufacturer', :deep => true
# end
# class HItems
#   include HappyMapper
# 
#   tag 'Items' # if you put class in module you need tag
#   # element :total_results, Integer, :tag => 'TotalResults'
#   # element :total_pages, Integer, :tag => 'TotalPages'
#   has_many :items, Item
# end

# class Item
#   include SAXMachine
#   
#   element :ASIN, :as => :asin
#   element :DetailPageUrl, :as => :detail_page_url
#   element :Manufacturer, :as => :manufacturer
# end
# class Items
#   include SAXMachine
#   elements :Item, :as => :items
# end

# amazon.xml
# 68c445f76b7645f0883b33cddc0874f9444a4f4c - 100.000 times
# sax-machine 84.890000   1.490000  86.380000 ( 89.622164)
# fdf075962fb73dd8979446a0fbbedff4882cbdbf - 100.000 times
# sax-machine 86.550000   1.460000  88.010000 ( 91.456097)
# benchmark do |t|
#   t.report("sax-machine") do
#     benchmark_iterations.times {
#       Items.new.parse(xml)
#     }
#   end
#   
#   # t.report("happymapper") do
#   #   benchmark_iterations.times {
#   #     HItems.parse(xml)
#   #   }
#   # end
# end