class AdmissionApp < ActiveRecord::Base
  
  attr_accessible :additional_info, 
  								:barcode,
  								:box_count, 
  								:cargo_name, 
  								:code_number,
  								:expected_date, 
  								:in_box_count, 
  								:notes, 
  								:unit_count, 
  								:unit_id, 
  								:user_id, 
  								:vehicle

  belongs_to :user

  validates_presence_of :unit_id,
  											:cargo_name, 
  											:expected_date, 
  											:unit_count, 
  											:in_box_count,
  											:box_count

  attr_accessor :unit

  UNITS = %w(shtuk butil upak paleta);

  def unit
    UNITS[unit_id]
  end

end
