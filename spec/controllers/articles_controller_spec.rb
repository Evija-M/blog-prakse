require 'rails_helper'

describe ArticlesController do
  context '#showarchived' do
    let(:article1) { create :article, :archived }
    let(:article2) { create :article, :other}
    let(:article3) { create :article, :archived  }
    let(:article4) { create :article, :other }
    let(:article5) { create :article, :archived }

    it 'list of archived articles' do
      get :showarchived
      expect(assigns(:articles)).to eq([article1, article3, article5])
      expect(assigns(:articles)).not_to eq([article2, article4])
    end
  end
end
