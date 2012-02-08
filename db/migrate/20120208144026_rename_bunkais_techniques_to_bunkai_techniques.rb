class RenameBunkaisTechniquesToBunkaiTechniques < ActiveRecord::Migration
  def change
    rename_table 'bunkais_techniques', 'bunkai_techniques'
  end
end
