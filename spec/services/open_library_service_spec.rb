require 'rails_helper'

RSpec.describe OpenLibraryService do
  context 'class methods' do
    it '.get_book returns books with a given location in the title' do
      books_response = File.read('spec/fixtures/books_response.json')
      stub_request(:get, "http://openlibrary.org/search.json?q=denver,co")
        .to_return(status: 200, body: books_response, headers: {})

      result = OpenLibraryService.get_books('denver,co')
      expect(result).to be_a Hash
      expect(result).to have_key :docs
      expect(result[:docs]).to be_an Array
      expect(result[:docs]).to be_all Hash
      
      result[:docs][0..4].each do |book|
        expect(book).to have_key :title
        expect(book[:title]).to be_a String
        
        expect(book).to have_key :isbn
        expect(book[:isbn]).to be_an Array
        expect(book[:isbn]).to be_all String
        expect(book[:isbn].count).to eq 2

        expect(book).to have_key :publisher
        expect(book[:publisher]).to be_an Array
        expect(book[:publisher]).to be_all String
        expect(book[:publisher].count).to eq 1
      end
    end
  end
end
