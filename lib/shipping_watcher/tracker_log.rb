class TrackerLog < ActiveRecord::Base
  belongs_to :tracker
  belongs_to :status
  belongs_to :shipper
end