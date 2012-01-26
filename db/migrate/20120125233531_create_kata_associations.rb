class CreateKataAssociations < ActiveRecord::Migration
  def change
    create_table :kata_associations do |t|
      t.references :bunkai
      t.references :kata

      t.timestamps
    end
  end
end
