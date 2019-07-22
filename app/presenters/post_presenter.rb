class PostPresenter
  def present(post)
    {
      title: post.title,
      link: post.link,
      date: post.pubDate&.strftime("%m/%d/%Y"),
      description: post.description,
      creator: post.dc_creator,
      content: post.content_encoded.html_safe,
    }
  end
end
