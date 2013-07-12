class ReleaseItem < ActiveRecord::Base

  belongs_to :release_app

  attr_accessible :add_services, :bar_code, :box_count, :code_number, :name, :unit_count, :unit_id

  validates_presence_of :name

  validates_presence_of :unit_count
  # validates_presence_of :box_count, :unless => :unit_count?

  attr_accessor :unit

  UNITS = %w(shtuk butil upak paleta metr_pog rulon bochka kont);

  def unit
    UNITS[unit_id]
  end

end
