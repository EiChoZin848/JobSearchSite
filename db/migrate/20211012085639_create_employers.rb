class CreateEmployers < ActiveRecord::Migration
  def self.up
    create_table :employers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :info

      t.timestamps
    end
  end

  def self.down
    drop_table :employers
  end
end
