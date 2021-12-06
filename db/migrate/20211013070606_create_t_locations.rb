class CreateTLocations < ActiveRecord::Migration
  def self.up
    create_table :t_locations do |t|
      t.string :city

      t.timestamps
    end
  end

  def self.down
    drop_table :t_locations
  end
end
