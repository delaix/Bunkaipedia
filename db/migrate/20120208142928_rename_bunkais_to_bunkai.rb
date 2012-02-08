class RenameBunkaisToBunkai < ActiveRecord::Migration
  def change
    rename_table 'bunkais', 'bunkai'
  end
end
