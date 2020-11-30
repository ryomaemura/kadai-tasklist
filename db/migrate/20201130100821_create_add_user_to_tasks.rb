class CreateAddUserToTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :add_user_to_tasks do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
