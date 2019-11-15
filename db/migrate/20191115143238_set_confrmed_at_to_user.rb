class SetConfrmedAtToUser < ActiveRecord::Migration[6.0]
  def self.up
    User.where(confirmed_at: nil).find_each { |u| u.update(confirmed_at: 1.day.ago) }
  end

  def self.down; end
end
