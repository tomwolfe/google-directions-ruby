require 'net/http'
require 'nokogiri'
require 'google_directions'

class GoogleDirections
  
  def initialize(optimize, mode, *locations)
    base_url = "http://maps.googleapis.com/maps/api/directions/xml?sensor=false&units=metric&"
    options = "origin=#{transcribe(locations[0])}&mode=#{mode}&waypoints=optimize:#{optimize}|" 
    @xml_call = base_url + options + waypoints(locations)
    @status = find_status
  end

  # an example URL to be generated
  #http://maps.googleapis.com/maps/api/directions/xml?origin=Adelaide,SA&waypoints=optimize:true|Barossa+Valley,SA|Clare,SA|Connawarra,SA|McLaren+Vale,SA&sensor=false
  
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
      drive_time = 0
      doc = Nokogiri::XML(xml)
      doc.css("duration value").each do |duration|
      	drive_time += duration.text.to_i
      end
      convert_to_minutes(drive_time)
    end
  end

  def distance_in_km
    if @status != "OK"
      distance_in_km = 0
    else
      doc = Nokogiri::XML(xml)
      meters = 0
      doc.css("distance value").each do |dist|
      	meters += dist.text.to_i
      end
      distance_in_km = (meters / 1000).round
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
    
    def waypoints(locations)
		# ignore the starting location and for the last location do not add the trailing "|"
		waypoint_options = ''
		locations[1..-1-1].each do |loc|
			waypoint_options += "#{transcribe(loc)}|"
		end
		waypoint_options += "#{transcribe(locations.last)}"
	end

    def get_url(url)
      Net::HTTP.get(::URI.parse(::URI.encode(url)))
    end
  
end

