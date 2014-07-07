#name
class Status < ActiveRecord::Base
  has_many :tracker
  has_many :tracker_logs
end