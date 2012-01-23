class CreateTechniques < ActiveRecord::Migration
  def change
    create_table :techniques do |t|
      t.text :description

      t.timestamps
    end
  end
end
