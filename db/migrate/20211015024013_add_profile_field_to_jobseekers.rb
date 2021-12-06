class AddProfileFieldToJobseekers < ActiveRecord::Migration
  def self.up
    add_column :jobseekers, :profile, :string
  end

  def self.down
    remove_column :jobseekers, :profile
  end
end
