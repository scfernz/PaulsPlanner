class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.datetime :date
      t.string :location
      t.string :description
      t.integer :created_by

      t.timestamps null: false
    end
  end
end
