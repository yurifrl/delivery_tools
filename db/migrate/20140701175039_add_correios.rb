class AddCorreios < ActiveRecord::Migration
  def self.up
    Shipper.create(:name => 'correios', :active => true)
  end
  def self.down
    Shipper.delete_all(:name => 'correios')
  end
end
