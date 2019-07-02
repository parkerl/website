require 'json'

desc "Fetch EarthVectors blog posts from Medium RSS Feed"
task fetch_blog_posts: :environment do
  posts = FeedReader.new.items.map do |post|
    PostPresenter.new.present(post)
  end

  File.open(Rails.root.join('public', 'blog_posts.json'), "wb") do |f|
    f.write(posts.to_json)
  end
end
