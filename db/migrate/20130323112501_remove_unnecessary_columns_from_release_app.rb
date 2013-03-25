class RemoveUnnecessaryColumnsFromReleaseApp < ActiveRecord::Migration
  def change
  	remove_column :release_apps, :cargo_name, :consignment, :code_number, :unit_id, :unit_count, :in_box_count, :box_count
  	rename_column :release_apps, :additional_info, :notes
  end
end
