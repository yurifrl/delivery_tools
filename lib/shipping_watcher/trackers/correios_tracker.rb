require 'correios-sro-xml'
# This is a Pure Ruby Object class, its methods return clean data, to be stored in the database
# It sums the three arguments and returns that value.
#

class CorreiosTracker
  #shipped
  #transit
  #delivered
  #failed

  TIPOS = {
      1 => {'BDE' => [], 'BDI' => [], 'BDR' => [], 'BLQ' => [], 'CAR' => [], 'CD' => [], 'CMT' => [], 'CO' => [], 'CUN' => [], 'DO' => [], 'EST' => [], 'FC' => [], 'IDC' => [], 'LDI' => [], 'LDE' => [], 'OEC' => [], 'PAR' => [], 'PMT' => [], 'PO' => [], 'RO' => [], 'TRI' => []},
      2 => {'BDE' => [], 'BDI' => [], 'BDR' => [], 'BLQ' => [], 'CAR' => [], 'CD' => [], 'CMT' => [], 'CO' => [], 'CUN' => [], 'DO' => [], 'EST' => [], 'FC' => [], 'IDC' => [], 'LDI' => [], 'LDE' => [], 'OEC' => [], 'PAR' => [], 'PMT' => [], 'PO' => [], 'RO' => [], 'TRI' => []},
      3 => {'BDE' => [0, 1], 'BDI' => [0, 1], 'BDR' => [0, 1], 'BLQ' => [], 'CAR' => [], 'CD' => [], 'CMT' => [], 'CO' => [], 'CUN' => [], 'DO' => [], 'EST' => [], 'FC' => [], 'IDC' => [], 'LDI' => [], 'LDE' => [], 'OEC' => [], 'PAR' => [], 'PMT' => [], 'PO' => [], 'RO' => [], 'TRI' => []},
      4 => {'BDE' => [], 'BDI' => [], 'BDR' => [], 'BLQ' => [], 'CAR' => [], 'CD' => [], 'CMT' => [], 'CO' => [], 'CUN' => [], 'DO' => [], 'EST' => [], 'FC' => [], 'IDC' => [], 'LDI' => [], 'LDE' => [], 'OEC' => [], 'PAR' => [], 'PMT' => [], 'PO' => [], 'RO' => [], 'TRI' => []}
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