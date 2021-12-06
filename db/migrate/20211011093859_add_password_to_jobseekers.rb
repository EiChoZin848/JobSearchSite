class AddPasswordToJobseekers < ActiveRecord::Migration
  def self.up
    add_column :jobseekers, :encrypted_password, :string
  end

  def self.down
    remove_column :jobseekers, :encrypted_password
  end
end
