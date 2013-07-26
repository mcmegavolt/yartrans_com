class AddStateToReleaseApp < ActiveRecord::Migration
  def change
    add_column :release_apps, :state, :string
  end
end
