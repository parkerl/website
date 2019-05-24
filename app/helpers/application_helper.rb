module ApplicationHelper
  require "rss"
  require "open-uri"

  def blog_posts
    rss = RSS::Parser.parse(open("https://medium.com/feed/earthvectors").read, false).items
    rss.map do |post|
      {
        title: post.title,
        date: post.pubDate,
        link: post.link,
        description: post.description,
        creator: post.dc_creator,
        content: post.content_encoded.html_safe,
      }
    end
  end
end
