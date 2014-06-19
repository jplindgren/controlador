class RemoveProfileIdFromProject < ActiveRecord::Migration
  def change
  	remove_column :projects, :profile_id
  end
end
