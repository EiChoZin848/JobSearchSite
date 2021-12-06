class CreateTAppliedjobs < ActiveRecord::Migration
  def self.up
    create_table :t_appliedjobs do |t|
      t.integer :jobseeker_id
      t.integer :t_joboffers_id

      t.timestamps
    end
  end

  def self.down
    drop_table :t_appliedjobs
  end
end
