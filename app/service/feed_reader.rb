require 'rss'
require 'open-uri'

class FeedReader
  def items
      io = Kernel.open(Figaro.env.FEED_URI).read
      RSS::Parser.parse(io, false).items.sort_by(&:pubDate).reverse
  end
end
