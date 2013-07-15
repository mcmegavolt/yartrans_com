class Report < ActiveRecord::Base

	REPORT_CATEGORIES = %w(hranenie uslugi schet)
  
  belongs_to :user
  
  attr_accessible :file, :file_cache, :report_category_id

  mount_uploader :file, ReportFileUploader

  validates_presence_of :file, :report_category_id

  default_scope order('created_at DESC')

  def category
  	I18n.t(:"reports.categories.#{REPORT_CATEGORIES[self.report_category_id]}")
  end

end
