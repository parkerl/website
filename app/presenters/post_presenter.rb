class PostPresenter
  def present(post)
    {
      title: post.title,
      date: post.pubDate,
      description: post.description,
      creator: post.dc_creator,
      content: ContentPresenter.new.call(post.content_encoded),
    }
  end
end
