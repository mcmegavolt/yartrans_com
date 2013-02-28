class UserObserver < ActiveRecord::Observer

  def after_update(user)
	  ActivityFeed.create({class_name: user.class.name, event_type_id: 1, record_id: user.id, user_id: user.updated_by})
	end

  def after_create(user)
	  ActivityFeed.create({class_name: user.class.name, event_type_id: 2, record_id: user.id, user_id: user.updated_by})
	end

end
