require 'correios-sro-xml'
# This is a Pure Ruby Object class, its methods return clean data, to be stored in the database
# It sums the three arguments and returns that value.
#

class CorreiosTracker
  #shipped
  #transit
  #delivered
  #failed
  COMMON_STATES = [2,3,4,5,6,7,8,9,10,12,19,20,21,22,23,24,25,26,28,32,33,34,35,36,37,38,40,41,42,43,45,46,47,48,49,50,51,52,53,55,56,57,58,59,69]
  TIPOS = {
      1 => {'BDE' => [], 'BDI' => [], 'BDR' => [], 'BLQ' => [], 'CAR' => [], 'CD' => [], 'CMT' => [], 'CO' => [], 'CUN' => [], 'DO' => [], 'EST' => [], 'FC' => [], 'IDC' => [], 'LDI' => [], 'LDE' => [], 'OEC' => [], 'PAR' => [], 'PMT' => [], 'PO' => [0,1,9], 'RO' => [], 'TRI' => []},
      2 => {'BDE' => [], 'BDI' => [], 'BDR' => [], 'BLQ' => [], 'CAR' => [], 'CD' => [0,1,2,3], 'CMT' => [0], 'CO' => [1], 'CUN' => [0,1], 'DO' => [0,1,2], 'EST' => [1,2,3,4,5,6,9], 'FC' => [2,3], 'IDC' => [], 'LDI' => [], 'LDE' => [], 'OEC' => [0], 'PAR' => [15,16,17,18], 'PMT' => [1], 'PO' => [], 'RO' => [0,1], 'TRI' => [0]},
      3 => {'BDE' => [0, 1], 'BDI' => [0, 1], 'BDR' => [0, 1], 'BLQ' => [], 'CAR' => [], 'CD' => [], 'CMT' => [], 'CO' => [], 'CUN' => [], 'DO' => [], 'EST' => [], 'FC' => [], 'IDC' => [], 'LDI' => [], 'LDE' => [], 'OEC' => [], 'PAR' => [], 'PMT' => [], 'PO' => [], 'RO' => [], 'TRI' => []},
      4 => {'BDE' => COMMON_STATES, 'BDI' => COMMON_STATES, 'BDR' => COMMON_STATES, 'BLQ' => [1], 'CAR' => [], 'CD' => [], 'CMT' => [], 'CO' => [], 'CUN' => [], 'DO' => [], 'EST' => [], 'FC' => [1,4,5,7], 'IDC' => [1,2,3,4,5,6,7,8,9], 'LDI' => [1,2,3,14], 'LDE' => [], 'OEC' => [], 'PAR' => [], 'PMT' => [], 'PO' => [], 'RO' => [], 'TRI' => []}
  }

  @user
  @password
  @tracking_code
  @sro

  def initialize(user, password, code)
    @user          = user
    @password      = password
    @tracking_code = code
  end

  def valid?
    get_sro.nil? ? false : true
  end

  def status
    index = TIPOS.map do |o|
      o.last[get_sro.events[0].type].grep(get_sro.events[0].status.to_i).any? ? o.first : next
    end
    if index.compact!.length == 1
      index.first
    else
      4
    end
  end

  def log
    {snapshot: get_sro.to_json, code: @tracking_code, message: get_sro.events[0].description, status_id: status}
  end

  private
  def get_tracking
    Correios::SRO::Tracker.new(user: @user, password: @password)
  end

  def get_sro
    @sro ||= get_tracking.get(@tracking_code)
  end

  def get_webservice_response
    Hash.from_xml(Correios::SRO::WebService.new(get_tracking).request!)
  end
end