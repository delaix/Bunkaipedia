class AddKataIdTobunkai < ActiveRecord::Migration
  def change
    add_column :bunkais, :kata_id, :integer
  end
end
