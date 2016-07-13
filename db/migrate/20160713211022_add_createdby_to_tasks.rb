class AddCreatedbyToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :createdby_id, :integer
  end
end
