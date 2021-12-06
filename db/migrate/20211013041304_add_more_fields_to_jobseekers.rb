class AddMoreFieldsToJobseekers < ActiveRecord::Migration
  def self.up
    add_column :jobseekers, :phone, :string
    add_column :jobseekers, :category, :string
    add_column :jobseekers, :skills, :string
    add_column :jobseekers, :about, :string
    add_column :jobseekers, :location, :string
  end

  def self.down
    remove_column :jobseekers, :location
    remove_column :jobseekers, :about
    remove_column :jobseekers, :skills
    remove_column :jobseekers, :category
    remove_column :jobseekers, :phone
  end
end
