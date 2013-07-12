# set :output, "/path/to/my/cron_log.log"

# every 1.day, :at => '10:00 am' do
#   runner "User.debt_warning"
# end

every 1.hour do
  runner "User.debt_warning"
end

