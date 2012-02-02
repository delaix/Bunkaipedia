class DropImagesTable < ActiveRecord::Migration
  def up
    drop_table :images
  end

  def down
    create_table :images do |t|
      t.string :name
      t.string :extension
      t.references :viewable, :polymorphic => true 
      
      t.timestamps  
    end
    add_index :images, :name
  end
end
