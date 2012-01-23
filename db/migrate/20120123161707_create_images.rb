class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :extension
      t.references :viewable, :polymorphic => true 
      
      t.timestamps  
    end
    add_index :images, :name
  end
end
