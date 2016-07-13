class AddTitleToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :title, :string
  end
end
