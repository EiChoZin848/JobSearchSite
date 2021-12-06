class CreateTJoboffers < ActiveRecord::Migration
  def self.up
    create_table :t_joboffers do |t|
      t.string :employer_id
      t.string :title
      t.string :minsalary
      t.string :maxsalary
      t.string :location
      t.string :skills
      t.string :description
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :t_joboffers
  end
end
