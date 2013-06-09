class AddAltEmailToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :alt_email, :string
  end
end
