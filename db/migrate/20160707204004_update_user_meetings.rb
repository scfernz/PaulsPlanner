class UpdateUserMeetings < ActiveRecord::Migration
  def change
    rename_table :user_meetings, :meetings_users
    change_table :meetings_users do |t|
      t.remove :user_id, :meeting_id, :can_edit?
      t.belongs_to :user, index: true
      t.belongs_to :meeting, index: true
    end
  end
end
