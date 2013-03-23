class RemoveUnitCountFromReleaseApp < ActiveRecord::Migration
  remove_column :release_apps, :unit_count
end
