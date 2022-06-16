# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchiveArticlesJob, type: :job do
  ActiveJob::Base.queue_adapter = :test
  it 'returns correct number of queued jobs' do
    have_enqueued_jobs 0
    ArchiveArticlesJob.perform_now
    have_enqueued_jobs 1
  end
  it 'makes sure "runner" statements exist' do
    schedule = Whenever::Test::Schedule.new(file: 'config/schedule.rb')
    assert_equal 1, schedule.jobs[:runner].count
    schedule.jobs[:runner].each { |job| instance_eval job[:task] }
  end
  it 'performs job after it has been queued' do
    ArchiveArticlesJob.perform_later
    perform_job
    have_performed_jobs 1
  end
end
