class CreateUserMeetings < ActiveRecord::Migration
  def change
    create_table :user_meetings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :meeting, index: true, foreign_key: true
      t.boolean :can_edit?

      t.timestamps null: false
    end
  end
end
