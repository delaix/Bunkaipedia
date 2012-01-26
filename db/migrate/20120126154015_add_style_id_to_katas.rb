class AddStyleIdToKatas < ActiveRecord::Migration
  def change
    add_column :kata, :style_id, :integer
  end
end
