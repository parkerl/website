require 'rails_helper'

describe ContentPresenter do
  describe "#call" do
    context "document does not contain iframes" do
      it "returns html_safe string" do
        raw_html = "<div></div>"
        result = described_class.new.call(raw_html)

        expect(result).to eq("<div></div>")
      end

      it "does not add script tags if gist iframes with js extensions are not present" do
        raw_html = "<iframe></iframe>"
        response_text = <<~HTML.strip
          data-autoselect\nclass=\"form-control input-monospace input-sm\"\n
          value=\"&lt;script src=&quot;https://gist.github.com/georgeAbot/33af4e1c47506ba8498ee2a6b21cdb68&quot;
          &gt;&lt;/script&gt;\"\n      aria-label=\"Clone this repository at &lt;script src=&quot;
          https://gist.github.com/georgeAbot/33af4e1c47506ba8498ee2a6b2;cheese;</iframe>
        )
        HTML
        allow(HTTParty).to receive(:get).and_return(double(:party, success?: true, body: response_text))

        expected_html = "<iframe></iframe>".html_safe

        result = described_class.new.call(raw_html)

        expect(result).to eq(expected_html)
      end
    end

    context "document contains iframes" do
      it "returns an html document with script tags for all gist iframes" do
        raw_html = "<iframe></iframe>"
        response_text = <<~HTML.strip
          data-autoselect\nclass=\"form-control input-monospace input-sm\"\n
          value=\"&lt;script src=&quot;https://gist.github.com/georgeAbot/33af4e1c47506ba8498ee2a6b21cdb68.js&quot;
          &gt;&lt;/script&gt;\"\n      aria-label=\"Clone this repository at &lt;script src=&quot;
          https://gist.github.com/georgeAbot/33af4e1c47506ba8498ee2a6b2;cheese.js;</iframe>
        )
        HTML
        allow(HTTParty).to receive(:get).and_return(double(:party, success?: true, body: response_text))

        expected_html = "<iframe></iframe><script src=\"https://gist.github.com/georgeAbot/33af4e1c47506ba8498ee2a6b21cdb68.js\"></script>".html_safe

        result = described_class.new.call(raw_html)

        expect(result).to eq(expected_html)
      end

      it "does not add script tags if gist iframes with js extensions are not present" do
        raw_html = "<iframe></iframe>"
        response_text = <<~HTML.strip
          data-autoselect\nclass=\"form-control input-monospace input-sm\"\n
          value=\"&lt;script src=&quot;https://gist.github.com/georgeAbot/33af4e1c47506ba8498ee2a6b21cdb68&quot;
          &gt;&lt;/script&gt;\"\n      aria-label=\"Clone this repository at &lt;script src=&quot;
          https://gist.github.com/georgeAbot/33af4e1c47506ba8498ee2a6b2;cheese;</iframe>
        )
        HTML
        allow(HTTParty).to receive(:get).and_return(double(:party, success?: true, body: response_text))

        expected_html = "<iframe></iframe>".html_safe

        result = described_class.new.call(raw_html)

        expect(result).to eq(expected_html)
      end

      it "does not add script tags if gist requests are not successful" do
        raw_html = "<iframe></iframe>"
        response_text = <<~HTML.strip
          data-autoselect\nclass=\"form-control input-monospace input-sm\"\n
          value=\"&lt;script src=&quot;https://gist.github.com/georgeAbot/33af4e1c47506ba8498ee2a6b21cdb68&quot;
          &gt;&lt;/script&gt;\"\n      aria-label=\"Clone this repository at &lt;script src=&quot;
          https://gist.github.com/georgeAbot/33af4e1c47506ba8498ee2a6b2;cheese;</iframe>
        )
        HTML
        allow(HTTParty).to receive(:get).and_return(double(:party, success?: false, body: response_text))

        expected_html = "<iframe></iframe>".html_safe

        result = described_class.new.call(raw_html)

        expect(result).to eq(expected_html)
      end
    end
  end
end
