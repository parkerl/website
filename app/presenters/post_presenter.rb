class PostPresenter
  def present(post)
    {
      title: post.title,
      date: post.pubDate,
      description: post.description,
      creator: post.dc_creator,
      content: post.content_encoded.html_safe,
    }
  end
end
