class AddStaffRefToAdmissionAndReleaseApp < ActiveRecord::Migration
	def change
    add_column :admission_apps, :staff_id, :integer
    add_column :release_apps, :staff_id, :integer

    add_index :admission_apps, :staff_id
    add_index :release_apps, :staff_id
  end
end
