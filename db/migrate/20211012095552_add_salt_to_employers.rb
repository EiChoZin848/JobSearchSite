class AddSaltToEmployers < ActiveRecord::Migration
  def self.up
    add_column :employers, :salt, :string
  end

  def self.down
    remove_column :employers, :salt
  end
end
