
		require 'faker'

		Role.create([ { name: 'Admin' }, { name: 'Director' }, { name: 'Manager' }, { name: 'Client' } ])

		User.new do |user|
			user.email = 'admin@yartrans.ua'
			user.password = 'mcmegavolt'
			user.role_ids = [Role.find_by_name('Admin').id] 
			## Profile
			user.build_profile
      user.profile.user_id = user.id
      user.profile.name = Faker::Company.name
      user.profile.personal_id = 'ADMIN'
      user.profile.phone_main = Faker::PhoneNumber.phone_number
      user.profile.phone_alternate = Faker::PhoneNumber.phone_number
      user.save
		end

		User.new do |user|
			user.email = 'boss@yartrans.ua'
			user.password = 'mcmegavolt'
			user.role_ids = [Role.find_by_name('Director').id] 
			## Profile
			user.build_profile
      user.profile.user_id = user.id
      user.profile.name = Faker::Company.name
      user.profile.personal_id = 'DIRECTOR'
      user.profile.phone_main = Faker::PhoneNumber.phone_number
      user.profile.phone_alternate = Faker::PhoneNumber.phone_number
      user.save
		end

		User.new do |user|		
			user.email = 'manager@yartrans.ua'
			user.password = 'mcmegavolt'
			user.role_ids = [Role.find_by_name('Manager').id]
			## Profile
			user.build_profile
      user.profile.user_id = user.id
      user.profile.name = Faker::Company.name
      user.profile.personal_id = 'MANAGER'
      user.profile.phone_main = Faker::PhoneNumber.phone_number
      user.profile.phone_alternate = Faker::PhoneNumber.phone_number
      user.save
		end

		User.new do |user|
			user.email = 'client@yartrans.ua'
			user.password = 'mcmegavolt'
			user.role_ids = [Role.find_by_name('Client').id] 
			## Profile
			user.build_profile
      user.profile.user_id = user.id
      user.profile.name = Faker::Company.name
      user.profile.personal_id = 'CLIENT'
      user.profile.phone_main = Faker::PhoneNumber.phone_number
      user.profile.phone_alternate = Faker::PhoneNumber.phone_number
      user.save

		end

		User.find_each do |u|
			u.confirm!
		end
		
		Rake::Task['db:populate'].invoke


