class AddImageToLovers < ActiveRecord::Migration[5.2]
  def change
    add_column :lovers, :image, :string
  end
end
