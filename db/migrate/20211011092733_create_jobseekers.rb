class CreateJobseekers < ActiveRecord::Migration
  def self.up
    create_table :jobseekers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :jobseekers
  end
end
