class AddFieldsToEmployers < ActiveRecord::Migration
  def self.up
    add_column :employers, :location, :string
    add_column :employers, :profile, :string
  end

  def self.down
    remove_column :employers, :profile
    remove_column :employers, :location
  end
end
