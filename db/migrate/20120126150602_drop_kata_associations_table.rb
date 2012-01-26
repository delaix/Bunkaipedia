class DropKataAssociationsTable < ActiveRecord::Migration
  def up
    drop_table :kata_associations
  end

  def down
    create_table :kata_associations do |t|
      t.references :bunkai
      t.references :kata

      t.timestamps
    end
  end
end
