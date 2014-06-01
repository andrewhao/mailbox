class AddSubjectToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :subject, :string
  end
end
