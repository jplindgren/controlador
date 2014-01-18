class RenameCustomerIdInProjectsToProfileId < ActiveRecord::Migration
  def change
  	rename_column :projects, :customer_id, :profile_id
  end
end
