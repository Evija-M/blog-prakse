# frozen_string_literal: true

require 'rails_helper'

describe ArticlesController do
  context '#showarchived' do
    let!(:article1) { create :article, :archived }
    let!(:article2) { create :article, :archived }
    let!(:article3) { create :article, :archived }

    it 'list of archived articles' do
      get :showarchived
      expect(assigns(:articles)).to eq([article1, article2, article3])
    end
  end
end
