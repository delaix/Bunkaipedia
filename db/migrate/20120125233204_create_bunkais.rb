class CreateBunkais < ActiveRecord::Migration
  def change
    create_table :bunkais do |t|
      t.string :title
      t.references :user

      t.timestamps
    end
  end
end
