class AddNeededColumnsToAdmissionApp < ActiveRecord::Migration
  def change

    # remove_column :admission_apps, :additional_info
    remove_column :admission_apps, :expected_date
    
    add_column :admission_apps, :admission_time, :time
    add_column :admission_apps, :admission_date, :date

  end
end
