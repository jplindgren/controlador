class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.date :start
      t.date :prevision

      t.timestamps
    end
  end
end
