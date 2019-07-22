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
          link: "www.hi.com",
          pubDate: DateTime.new(2019, 1, 1),
          description: 'This is soo amazing.',
          dc_creator: 'Mihir Parikh',
          content_encoded: 'This is cool stuff',
        ),
        double(
          :another_item,
          title: 'Newest Blog',
          link: "www.blog.com",
          pubDate: DateTime.new(2019, 2, 2),
          description: 'A great description.',
          dc_creator: 'Andrew Courter',
          content_encoded: 'enconded content',
        ),
      ]
    end

    it 'should show blog articles' do
      visit root_path

      within '#blog-section' do
        expect(page).to have_content 'Blog'
        expect(page).to have_content 'Our Blog Posts'

        within '[data-name="blog-post-1"]' do
          expect(page).to have_link 'Newest Blog', href: "www.blog.com"
          expect(page).to have_content 'Andrew Courter'
          expect(page).to have_content '02/02/2019'
          expect(page).to have_content 'A great description.'
          expect(page).to have_content 'Continue Reading...'
        end

        within '[data-name="blog-post-2"]' do
          expect(page).to have_link 'Coolest Blog', href: "www.hi.com"
          expect(page).to have_content 'Mihir Parikh'
          expect(page).to have_content '01/01/2019'
          expect(page).to have_content 'This is soo amazing.'
          expect(page).to have_content 'Continue Reading...'
        end
      end
    end
  end
end
