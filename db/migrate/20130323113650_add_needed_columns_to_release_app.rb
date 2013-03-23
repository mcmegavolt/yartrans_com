class AddNeededColumnsToReleaseApp < ActiveRecord::Migration
  def change
    add_column :release_apps, :release_date, :date
    add_column :release_apps, :release_time, :time
    add_column :release_apps, :recipient, :text
    add_column :release_apps, :vehicle, :text
  end
end
