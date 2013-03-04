class ReleaseApp < ActiveRecord::Base

  attr_accessible :additional_info,
  								:box_count, 
  								:cargo_name, 
  								:code_number, 
  								:consignment, 
  								:in_box_count, 
  								:unit_count, 
  								:unit_id, 
  								:user_id


  belongs_to :user

  validates_presence_of :unit_id,
  											:cargo_name, 
  											:unit_count, 
  											:in_box_count,
  											:box_count

  attr_accessor :unit

  UNITS = %w(shtuk butil upak paleta);

  def unit
    UNITS[unit_id]
  end

end
