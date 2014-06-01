class Letter < ActiveRecord::Migration
  def change
    add_column :letters, :draft, :boolean
  end
end
