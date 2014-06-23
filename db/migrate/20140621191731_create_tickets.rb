class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
    	t.integer :friendly_id
      t.string :description
      t.boolean :completed

      t.timestamps
    end
    add_index :tickets, :friendly_id

    add_column :tickets, :project_id, :integer
  	add_index :tickets, :project_id
  end
end
