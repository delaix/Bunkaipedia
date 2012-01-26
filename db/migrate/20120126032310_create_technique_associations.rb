class CreateTechniqueAssociations < ActiveRecord::Migration
  def change
    create_table :technique_associations do |t|
      t.references :bunkai
      t.references :technique

      t.timestamps
    end
    add_index :technique_associations, :bunkai_id
    add_index :technique_associations, :technique_id
  end
end
