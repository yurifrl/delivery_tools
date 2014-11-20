require 'grape'

require_relative 'shipping_watcher/tracker'
require_relative 'shipping_watcher/calculator'


# /noinspection RubyJumpError
# /noinspection ALL
module ShippingWatcher
  class API < Grape::API
    rescue_from :all
    format :json
    get do
      {status: 'show'}
    end

    params do
      requires :tracking_code, type: String
      requires :api_key, type: String
      requires :shipper_id, type: Integer
      requires :url, type: String
      optional :login_id, type: String
      optional :login_pass, type: String
      optional :login_token, type: String
      optional :action, type: Integer
    end
    post do
      obj = Tracker.where(code: params[:tracking_code]).first
      # get logs
      # noinspection ALL
      return {success: true, details: 'consult', status: obj.logs} if params[:action] == 1 && !obj.nil?
      if obj
        obj.log!
        # noinspection ALL
        return {success: true, details: 'consult', status: obj.get_status}
      end
      obj = Tracker.new do |tracker|
        tracker.code = params[:tracking_code]
        tracker.shipper_id = params[:shipper_id]
        tracker.url = params[:url]
        tracker.login_id = params[:login_id]
        tracker.login_pass = params[:login_pass]
        tracker.login_token = params[:login_token]
        tracker.api_key = params[:api_key]
      end
      if obj.try(:save)
        obj.log!
        {success: true, details: 'actual state', status: obj.get_status}
      else
        {success: false, details: obj.get_errors, status: obj.get_status}
      end
    end

    params do
      requires :zip, type: Hash do
        requires :cep_origem, type: String
        requires :cep_destino, type: String
        requires :items, type: Array do
          requires :peso, type: Float
          requires :comprimento, type: Float
          requires :largura, type: Float
          requires :altura, type: Float
        end
      end
    end
    post '/zip' do
      calc = Calculator.new
      calc.cep_origem = params[:zip][:cep_origem]
      calc.cep_destino = params[:zip][:cep_destino]
      calc.items = params[:zip][:items]
      calc.compute
    end

    params do
      requires :zip_code, type: String
    end
    post '/address_finder' do
      calc = Calculator.new
      calc.cep_origem = params[:zip_code]
      calc.address_finder
    end
  end
end
