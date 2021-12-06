class AddPasswordToEmployers < ActiveRecord::Migration
  def self.up
    add_column :employers, :encrypted_password, :string
  end

  def self.down
    remove_column :employers, :encrypted_password
  end
end
