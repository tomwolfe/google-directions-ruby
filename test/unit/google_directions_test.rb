require 'test_helper'

class GoogleDirectionsTest < Test::Unit::TestCase

  def test_happy_case
    directions = GoogleDirections.new(true, driving, "121 Gordonsville Highway, 37030", "155 Dixon Springs Hwy, 37030", "499 Gordonsville Highway, 38563")
    assert_equal(21, directions.distance_in_km)
    assert_equal(22, directions.drive_time_in_minutes)
    assert_equal("http://maps.google.com/maps/api/directions/xml?sensor=false&units=metric&origin=121+Gordonsville+Highway,+37030&mode=driving&waypoints=optimize:true|155+Dixon+Springs+Highway,+37030|499+Gordonsville+Highway,+38563", directions.xml_call)
    assert_not_nil(directions.xml =~ /36\.1773300/)
  end
  
  def test_directions_not_found
    directions = GoogleDirections.new(false, driving, "fasfefasdfdfsd", "499 Gordonsville Highway, 38563")
    assert_equal(0, directions.distance_in_miles)
    assert_equal(0, directions.drive_time_in_minutes)
    assert_equal("NOT_FOUND", directions.status)
  end
  
  def test_zero_results
    directions = GoogleDirections.new(false, driving, "COMMUNITY SOUTH HOSPITAL 1402 EAST COUNTY LINE ROAD, 46227", "499 Gordonsville Highway, 38563")
    assert_equal(0, directions.distance_in_miles)
    assert_equal(0, directions.drive_time_in_minutes)
    assert_equal("ZERO_RESULTS", directions.status)
  end
  
  
end
