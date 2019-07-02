class ContentPresenter
  def call(raw_html)
    document = Nokogiri::HTML::DocumentFragment.parse(raw_html)
    document_iframes = document.css("iframe")

    return raw_html if document_iframes.empty?

    document_iframes.each do |iframe|
      response = HTTParty.get(iframe.text)
      if response.success?
        regex = /#{"gist.github.com"}(.*?)#{".js&quot"}/
        match = response.body.slice(regex, 1)
        if match
          gist_url = "https://gist.github.com#{match}.js"
          iframe.add_next_sibling("<script src='#{gist_url}'></script>")
        end
      end
    end

    document.to_html
  end
end
