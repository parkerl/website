require 'rss'
require 'open-uri'

class FeedReader
  def items
      io = Kernel.open("https://medium.com/feed/earthvectors").read
      RSS::Parser.parse(io, false).items.sort_by(&:pubDate).reverse
  end
end
