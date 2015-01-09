require 'httparty'

class Notifier
  include HTTParty
  default_params :output => 'json'
  format :json

  def self.request(tracker)
    base_uri(tracker.url)
    post("#{tracker.url}?token=#{tracker.api_key}", :body => {tracking_code: tracker.code, status_name: tracker.status.name, status_id: tracker.status_id})
  end
end