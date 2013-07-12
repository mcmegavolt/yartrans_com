class AdmissionItem < ActiveRecord::Base
 
  belongs_to :admission_app
 
  attr_accessible :add_services, :bar_code, :box_count, :box_size, :box_weight, :code_number, :in_box_count, :name, :unit_count, :unit_id

  validates_presence_of :name, :in_box_count

  attr_accessor :unit

  UNITS = %w(shtuk butil upak paleta metr_pog rulon bochka kont);

  def unit
    UNITS[unit_id]
  end

end
