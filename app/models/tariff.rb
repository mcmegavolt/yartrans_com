class Tariff < ActiveRecord::Base
  
  belongs_to :user

  attr_accessible :file, :notes, :remove_file, :file_cache

	mount_uploader :file, TariffFileUploader

end
