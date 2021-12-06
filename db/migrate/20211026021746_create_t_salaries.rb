class CreateTSalaries < ActiveRecord::Migration
  def self.up
    create_table :t_salaries do |t|
      t.string :monthly

      t.timestamps
    end
  end

  def self.down
    drop_table :t_salaries
  end
end
