require 'rails_helper'

RSpec.describe 'Count of articles' do
  it 'returns count above 0' do
    count = Article.count
    expect(count).to be>0
  end
end