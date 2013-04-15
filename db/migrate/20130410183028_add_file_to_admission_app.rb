class AddFileToAdmissionApp < ActiveRecord::Migration
  def change
    add_column :admission_apps, :file, :string
  end
end
