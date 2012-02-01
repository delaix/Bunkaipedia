class AddAttachmentImageToManeuver < ActiveRecord::Migration
  def self.up
    add_column :maneuvers, :image_file_name, :string
    add_column :maneuvers, :image_content_type, :string
    add_column :maneuvers, :image_file_size, :integer
    add_column :maneuvers, :image_updated_at, :datetime
  end

  def self.down
    remove_column :maneuvers, :image_file_name
    remove_column :maneuvers, :image_content_type
    remove_column :maneuvers, :image_file_size
    remove_column :maneuvers, :image_updated_at
  end
end
