require 'net/http'
require 'nokogiri'
require 'google_directions'

class GoogleDirections
  
  def initialize(optimize, mode, *locations)
    base_url = "http://maps.google.com/maps/api/directions/xml?sensor=false&units=metric&"
    location_start = locations[0]
    options = "origin=#{transcribe(location_start)}&mode=#{mode}&waypoints=optimize:#{optimize}|" 
    @xml_call = base_url + options + waypoints(locations)
    @status = find_status
  end

  # an example URL to be generated
  #http://maps.googleapis.com/maps/api/directions/xml?origin=Adelaide,SA&destination=Adelaide,SA&waypoints=optimize:true|Barossa+Valley,SA|Clare,SA|Connawarra,SA|McLaren+Vale,SA&sensor=false
  
  def find_status
    doc = Nokogiri::XML(xml)
    doc.css("status").text
  end

  def xml
    unless @xml.nil?
       @xml
    else
      @xml ||= get_url(@xml_call)
    end
  end

  def xml_call
    @xml_call
  end

  def drive_time_in_minutes
    if @status != "OK"
      drive_time = 0
    else
      doc = Nokogiri::XML(xml)
      drive_time = doc.css("duration value").last.text
      convert_to_minutes(drive_time)
    end
  end

  def distance_in_km
    if @status != "OK"
      distance_in_km = 0
    else
      doc = Nokogiri::XML(xml)
      meters = doc.css("distance value").last.text
      distance_in_km = meters * 1000
    end
  end
  
  def status
    @status
  end
    
  private
  
    def convert_to_minutes(text)
      (text.to_i / 60).ceil
    end
  
    def transcribe(location)
      location.gsub(" ", "+")
    end
    
    def waypoints(location)
		# ignore the starting location and for the last location do not add the trailing "|"
		location[1..-1-1].each do |loc|
			waypoint_options += "#{transcribe(loc)}|"
		end
		waypoint_options += "#{transcribe(location.last)}"
	end

    def get_url(url)
      Net::HTTP.get(::URI.parse(url))
    end
  
end

