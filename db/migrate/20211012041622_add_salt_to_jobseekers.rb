class AddSaltToJobseekers < ActiveRecord::Migration
  def self.up
    add_column :jobseekers, :salt, :string
  end

  def self.down
    remove_column :jobseekers, :salt
  end
end
