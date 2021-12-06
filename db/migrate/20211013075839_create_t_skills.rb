class CreateTSkills < ActiveRecord::Migration
  def self.up
    create_table :t_skills do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :t_skills
  end
end
