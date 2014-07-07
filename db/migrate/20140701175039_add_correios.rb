class AddCorreios < ActiveRecord::Migration
  def self.up
    Shipper.create(:name => 'correios', :status => true)
  end
  def self.down
    Shipper.delete_all(:name => 'correios')
  end
end
