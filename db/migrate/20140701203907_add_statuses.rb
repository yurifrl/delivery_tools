class AddStatuses < ActiveRecord::Migration
  def self.up
    Status.create(:name => 'shipped')
    Status.create(:name => 'transit')
    Status.create(:name => 'delivered')
    Status.create(:name => 'failed')
  end
  def self.down
    Status.delete_all
  end
end
