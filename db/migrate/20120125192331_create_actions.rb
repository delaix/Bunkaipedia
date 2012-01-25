class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.text :description
      t.string :actor

      t.timestamps
    end
  end
end
