class AddAttachmentImageToTechnique < ActiveRecord::Migration
  def self.up
    add_column :techniques, :image_file_name, :string
    add_column :techniques, :image_content_type, :string
    add_column :techniques, :image_file_size, :integer
    add_column :techniques, :image_updated_at, :datetime
  end

  def self.down
    remove_column :techniques, :image_file_name
    remove_column :techniques, :image_content_type
    remove_column :techniques, :image_file_size
    remove_column :techniques, :image_updated_at
  end
end
