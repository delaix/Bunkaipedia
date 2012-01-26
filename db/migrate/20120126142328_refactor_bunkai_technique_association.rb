class RefactorBunkaiTechniqueAssociation < ActiveRecord::Migration
  def up
    drop_table :technique_associations
    create_table :bunkais_techniques do |t|
      t.references :bunkai
      t.references :technique
    end
    add_index :bunkais_techniques, :bunkai_id
    add_index :bunkais_techniques, :technique_id
  end

  def down
    drop_table :bunkais_techniques
    create_table :technique_associations do |t|
      t.references :bunkai
      t.references :technique

      t.timestamps
    end
    add_index :technique_associations, :bunkai_id
    add_index :technique_associations, :technique_id
  end
end
