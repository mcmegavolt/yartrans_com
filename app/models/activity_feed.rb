class ActivityFeed < ActiveRecord::Base
  attr_accessible :class_name, :event_type_id, :record_id, :user_id


  EVENT_TYPES = ['User was updated', 'User was created']

  def event_type
  	#
  end

end
