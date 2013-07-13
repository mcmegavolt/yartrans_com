namespace :user do
	desc "Warn all users with debt"
	task :warn => :environment do

		User.with_state(:debtor).each do |u|
			NotificationMailer.delay.debt_warning(u.email)
		end

	end
end