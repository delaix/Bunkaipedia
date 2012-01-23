class CreateKata < ActiveRecord::Migration
  def change
    create_table :kata do |t|
      t.text :name

      t.timestamps
    end
  end
end
