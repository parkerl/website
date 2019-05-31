class BlogsController < ApplicationController
  def index
    @posts = FeedReader.new.items.map do |post|
      PostPresenter.new.present(post)
    end
  end
end
