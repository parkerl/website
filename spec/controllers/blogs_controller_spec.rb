require 'rails_helper'

describe BlogsController, type: :controller do
  describe '#index' do
    let(:item) do
      double(
        :item,
        title: 'Title',
        pubDate: '1/1/2000',
        link: 'http://www.example.com',
        description: 'description',
        dc_creator: 'Mihir Parikh',
        content_encoded: 'This is cool stuff',
      )
    end

    before do
      feed_reader = instance_double(FeedReader, items: [item])
      allow(FeedReader).to receive(:new).and_return(feed_reader)
    end

    it 'should assign items from medium feed' do
      get :index

      expect(assigns(:posts)).to eq [PostPresenter.new.present(item)]
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('blogs/index')
    end
  end
end
