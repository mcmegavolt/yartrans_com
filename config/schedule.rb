set :output, "/home/yartrans/yartrans/shared/log/cron_log.log"

# every 1.day, :at => '10:00 am' do
#   runner "User.debt_warning"
# end

every 10.minutes do
  runner "User.debt_warning"
end

