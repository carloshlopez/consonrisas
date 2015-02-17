class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :fundation_name
      t.integer :num_tickets
      t.text :story
      t.string :video
      t.string :transport
      t.integer :fundation_id
      t.string :email

      t.timestamps
    end
  end
end
