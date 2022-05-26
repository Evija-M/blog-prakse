require 'rails_helper'

RSpec.describe "New article", type: :request do
  context "GET /new_article" do
    it "returns successful redirect" do
      get new_article_path
      expect(response).to have_http_status(200)
    end
  end
end

RSpec.describe "Creating new article" do
  context "GET /new_article" do
    it "returns new article page after submitting it" do
      visit new_article_path
      fill_in "Title", with: "valid title"
      click_on "Create Article"
      expect(page).to have_content("Body can't be blank")
      fill_in "Body", with: "valid body"
      click_on "Create Article"
      expect(page).to have_content("valid title")
      expect(page).to have_content("valid body")
    end
  end
end