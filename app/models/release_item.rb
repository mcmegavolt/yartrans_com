class ReleaseItem < ActiveRecord::Base

  belongs_to :release_app

  attr_accessible :add_services, :bar_code, :box_count, :code_number, :name, :unit_count, :unit_id



  attr_accessor :unit

  UNITS = %w(shtuk butil upak paleta);

  def unit
    UNITS[unit_id]
  end

end
