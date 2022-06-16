# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }
  permissions :restore?, :index? do
    let!(:user) { create :user, :admin }
    let!(:registred) { create :user, :registred }
    it 'grants permission only to admin to view users and restore deleted users' do
      expect(subject).to permit(user)
      expect(subject).not_to permit(registred)
    end
  end
end
