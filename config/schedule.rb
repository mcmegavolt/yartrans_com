set :output, "/home/yartrans/yartrans/shared/log/cron_log.log"
set :job_template, "bash -l -c ':job'"
# set :job_template, nil
# every 1.day, :at => '10:00 am' do
#   runner "User.debt_warning"
# end

every 10.minutes do
  rake "user:warn"
end

