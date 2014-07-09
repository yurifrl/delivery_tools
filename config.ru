require 'rack/cors'

# All support for cross-domain
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post]
  end
end
require File.expand_path('../environment', __FILE__)
require File.expand_path('../lib/shipping_watcher', __FILE__)

run ShippingWatcher::API
