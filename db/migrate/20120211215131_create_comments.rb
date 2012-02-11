class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.references :bunkai
      t.references :user

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :bunkai_id
  end
end
