class UpdateUserPhoneNumberFormat < ActiveRecord::Migration[6.0]
  def self.up
    User.where.not("phone like '+%'").find_each { |u| u.update(phone: "+#{u.phone}") }
  end

  def self.down; end
end
