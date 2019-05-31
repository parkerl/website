require 'acceptance_helper'
require 'rss'

describe 'Blog', type: :feature, js: true do
  before do
    allow(Kernel).to receive(:open).and_return(double(:io_object, read: double(:read_return_object)))
    allow(RSS::Parser).to receive(:parse).and_return(double(:parsed_items, items: items))
  end

  context 'when there are some blogs to display' do
    let(:items) do
      [
        double(
          :item,
          title: 'Coolest Blog',
          pubDate: '1/1/2000',
          description: 'This is soo amazing.',
          dc_creator: 'Mihir Parikh',
          content_encoded: 'This is cool stuff',
        )
      ]
    end

    it 'should show blog articles' do
      visit '/blogs'

      expect(page).to have_content 'EarthVectors Blog'
      expect(page).to have_content 'Coolest Blog'
      expect(page).to have_content 'Mihir Parikh'
      expect(page).to have_content 'This is soo amazing.'
      expect(page).to have_content '1/1/2000'
    end
  end
end
