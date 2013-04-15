class AddFileToReleaseApp < ActiveRecord::Migration
  def change
    add_column :release_apps, :file, :string
  end
end
