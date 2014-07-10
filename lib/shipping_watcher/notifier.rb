require 'httparty'

class Notifier
  include HTTParty
  default_params :output => 'json'
  format :json

  def self.request(tracker)
    self.class.base_uri(tracker.url)
    self.class.post('/', :query => {tracking_code: tracker.code, status_name: tracker.status_name, status_id: tracker.status_id})
  end
end