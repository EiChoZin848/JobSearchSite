class AddPasswordResetTokenToEmployers < ActiveRecord::Migration
  def self.up
    add_column :employers, :password_reset_token, :string
  end

  def self.down
    remove_column :employers, :password_reset_token
  end
end
