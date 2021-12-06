class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :employers, :email, :unique => true
    add_index :jobseekers, :email, :unique=> true
  end

  def self.down
    remove_index :employers, :email
    remove_index :jobseekers, :email
  end
end
