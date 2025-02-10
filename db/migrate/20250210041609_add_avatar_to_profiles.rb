class AddAvatarToProfiles < ActiveRecord::Migration[7.2]
  def change
    add_column :profiles, :avatar, :string
  end
end
