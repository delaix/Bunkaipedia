class ActionUpdate < ActiveRecord::Migration
  def change
    change_table :actions do |t|
      t.references :bunkai
    end  
  end
end
