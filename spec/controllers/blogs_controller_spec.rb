require 'rails_helper'

describe BlogsController, type: :controller do
  describe '#index' do
    let(:items) do
      [{
        title: 'Title',
        pubDate: '1/1/2000',
        link: 'http://www.example.com',
        description: 'description',
        dc_creator: 'Mihir Parikh',
        content_encoded: 'This is cool stuff',
      }].to_json
    end

    before do
      allow(File).to receive(:read).and_return(items)
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('blogs/index')
    end
  end
end
