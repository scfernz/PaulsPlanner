class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :tasks, :completed?, :completed
  end
end
