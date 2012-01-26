class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.references :kata

      t.timestamps
    end
    add_index :styles, :name, :unique => true
  end
end
