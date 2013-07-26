class AddStateToAdmissionApp < ActiveRecord::Migration
  def change
    add_column :admission_apps, :state, :string
  end
end
