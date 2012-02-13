class ChangeCommentsTextFromStringToText < ActiveRecord::Migration
  def up
    change_column :comments, :text, :text
  end

  def down
    change_column :comments, :text, :string
  end
end
