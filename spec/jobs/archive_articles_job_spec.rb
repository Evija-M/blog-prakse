# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchiveArticlesJob, type: :job do
  it 'returns correct number of queued jobs' do
    have_enqueued_jobs 0
    ArchiveArticlesJob.perform_now
    have_enqueued_jobs 1
  end
  it 'performs at correct time' do
    ArchiveArticlesJob.set(wait_until: Date.tomorrow.noon).perform_later
    expect(ArchiveArticlesJob).to have_been_performed.at(Date.tomorrow.noon)
  end
end
