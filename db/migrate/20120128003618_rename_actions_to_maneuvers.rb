class RenameActionsToManeuvers < ActiveRecord::Migration
  def change
      rename_table :actions, :maneuvers
  end 
end
