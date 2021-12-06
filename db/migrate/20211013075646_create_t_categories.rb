class CreateTCategories < ActiveRecord::Migration
  def self.up
    create_table :t_categories do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :t_categories
  end
end
