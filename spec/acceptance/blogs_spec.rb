require 'acceptance_helper'
require 'rss'

describe 'Blog', type: :feature, js: true do
  context 'when there are some blogs to display' do
    it 'should show blog articles' do
      visit blogs_path

      expect(page).to have_content 'EarthVectors Blog'
      expect(page).to have_content 'Outside-In Development'
      expect(page).to have_content 'David Madouros'
      expect(page).to have_content 'Hey there. David from EarthVectors'
    end
  end
end
