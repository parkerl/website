require "json"

class BlogsController < ApplicationController
  def index
    blog_posts_json = File.read(Rails.root.join('public', 'blog_posts.json'))

    @posts = JSON.parse(blog_posts_json)
  end
end
