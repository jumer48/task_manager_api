class AddForeignKeyToTasks < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :tasks, :users, column: :user_id
    add_index :tasks, :user_id  # Optional, if you want to add an index on the user_id for performance
  end
end
