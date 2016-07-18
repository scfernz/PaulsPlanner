class AddCancelledToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :cancelled, :boolean
  end
end
