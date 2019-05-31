require 'rails_helper'
require 'rss'

describe FeedReader do
  describe '#items' do
    let(:oldest_item) { double(:oldest_item, pubDate: DateTime.new(2000, 1, 1)) }
    let(:most_recent_item) { double(:most_recent_item, pubDate: DateTime.new(2000, 3, 1)) }
    let(:middle_item) { double(:middle_item, pubDate: DateTime.new(2000, 2, 1)) }

    let(:items) do
      [
        oldest_item,
        most_recent_item,
        middle_item,
      ]
    end

    before do
      ENV['FEED_URI'] = 'http://www.example.com'
      read_return_object = double(:read_return_object)
      io = double(:io_object, read: read_return_object)
      allow(Kernel).to receive(:open).with('http://www.example.com').and_return(io)
      parsed_items = double(:parsed_items, items: items)
      allow(RSS::Parser).to receive(:parse).with(read_return_object, false).and_return(parsed_items)
    end

    it 'should returns items from medium feed' do
      result = subject.items

      expect(result).to match_array items
    end

    it 'should by created date, descending' do
      result = subject.items

      expect(result).to eq [
        most_recent_item,
        middle_item,
        oldest_item
      ]
    end
  end
end
