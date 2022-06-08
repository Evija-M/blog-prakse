set :environment, "development"
set :output, { :error => 'log/crontab_errors.log' }

every 1.days do
    runner "ArchiveArticlesJob.new.perform_now"
end
