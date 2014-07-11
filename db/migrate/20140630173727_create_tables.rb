Foreigner.load
class CreateTables < ActiveRecord::Migration
  def change
    create_table :shippers do |t|
      t.string :name
      t.boolean :active
      t.timestamps
    end
    create_table :statuses do |t|
      t.string :name
      t.timestamps
    end
    create_table :trackers do |t|
      t.string :code, :null => false
      t.string :login_id
      t.string :login_pass
      t.string :login_token
      t.string :url
      t.references :shipper
      t.references :status
      # t.foreign_key :shippers
      # t.foreign_key :statuses
      t.timestamps
    end
    create_table :tracker_logs do |t|
      t.string :message
      t.string :code
      t.json :snapshot
      t.references :tracker
      t.references :status
      t.references :shipper
      # t.foreign_key :trackers
      # t.foreign_key :statuses
      # t.foreign_key :shippers
      t.timestamps
    end
    add_index :tracker_logs, :tracker_id
    add_index :tracker_logs, :status_id
    add_index :tracker_logs, :shipper_id
    add_index :trackers, :shipper_id
    add_index :trackers, :status_id
    add_index(:trackers, :code, unique: true)
  end
end