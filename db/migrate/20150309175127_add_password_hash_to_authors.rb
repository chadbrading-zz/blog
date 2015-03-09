class AddPasswordHashToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :password_hash, :string
  end
end
