#name
#status
class Shipper < ActiveRecord::Base
  has_many :trackers
  has_many :tracker_logs

  validates_uniqueness_of :name

  def to_class
    "#{name.pluralize}_tracker".camelize.constantize
  end
  def shipper_id
    id
  end
end