require 'json'

desc "Fetch EarthVectors blog posts from Medium RSS Feed"
task fetch_blog_posts: :environment do
  posts = FeedReader.new.items.map do |post|
    PostPresenter.new.present(post)
  end

  file_path = Rails.root.join('public', 'blog_posts.json')
  File.delete(file_path) if File.exist?(file_path)
  File.open(file_path, "wb") do |f|
    puts "writing new blog posts json file."
    f.write(posts.to_json)
  end
end
