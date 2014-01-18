class RenameCustomers < ActiveRecord::Migration
  def self.up
  	rename_table :customers, :profiles
  end

  def self.down
  	rename_table :profiles, :customers
  end
end
