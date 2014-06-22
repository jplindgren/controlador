class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
    	t.integer :friendly_id
      t.string :description

      t.timestamps
    end
    add_index :tickets, :friendly_id
  end
end
