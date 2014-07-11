require 'foreigner'
require 'active_record'
require_relative 'shipper'
require_relative 'status'
require_relative 'tracker_log'
require_relative 'trackers/correios_tracker'

class Tracker < ActiveRecord::Base
  belongs_to :shipper
  belongs_to :status

  validate :validate_url
  validate :validate_request
  validates :login_id, :login_pass, :shipper_id, presence: true
  validates :code, presence: true, uniqueness: true

  after_initialize :load_shipper

  @shipper

  def load_shipper
    @shipper = shipper.to_class.new(login_id, login_pass, code)
    self.update_attribute(:status_id, @shipper.status)
  end

  def new_status
    @shipper.status
  end

  def get_status
    {id: self.status_id, name: self.status.name}
  end

  def get_errors
    errors.collect { |o| "#{o} #{errors[o].first}" }.uniq
  end

  def log!
    log            = TrackerLog.new(@shipper.log)
    log.shipper_id = shipper_id
    log.tracker_id = id
    log.save
  end

  def status_changed?
    unless self.status_id
      return false
    end
    # log if status changed
    if self.status_id != @shipper.status
      log!
    else
      return false
    end
    true
  end

  def logs
    TrackerLog.where(tracker_id: id)
  end

  private

  def validate_request
    errors.add(:traking_code, 'not found') unless @shipper.valid?
  end

  def validate_url
    errors.add(:url, "can't be blank") if url.blank?
    begin
      uri  = URI.parse(url)
      resp = uri.kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      resp = false
    end

    unless resp
      errors.add(:url, 'is not valid')
    end
  end
end