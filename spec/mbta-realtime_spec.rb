require 'spec_helper'


describe MBTARealtime do
  
  describe "#routes" do
    it "should return a list of all the routes" do
      client = MBTARealtime::Client.new(api_key: "wX9NwuHnZU2ToO7GmGR9uw")
      routes = client.routes
      routes['mode'][0]['route_type'].should == '0'
      routes['mode'][0]['mode_name'].should == 'Subway'
    end
  end

  describe "#routes_by_stop" do
    it "should return a list of routes for a stop" do
      client = MBTARealtime::Client.new(api_key: "wX9NwuHnZU2ToO7GmGR9uw")
      routes = client.routes_by_stop(1395)
      routes['stop_id'].to_i.should == 1395
      routes['mode'].first['route'].length.should == 2
      routes['mode'].first['route'].first['route_name'].should == '10'
    end
  end
end

# describe MBTARealtime do
  
#   subject { MBTARealtime::Client.new('wX9NwuHnZU2ToO7GmGR9u') }

#   context "route queries" do
#     describe "#routes" do
#       it "returns an array of routes" do
#         expect(routes['mode'][0]['route_type']).to eq "0"
#         expect(routes['mode'][0]['mode_name']).to eq "Subway"
#       end

#     end
#     pending "#routes_by_stop"
#   end


#   context "stop queries" do
#     pending "#stops_by_route"
#     pending "#stops_by_location"
#     pending "#stops_by_location_name"
#   end


#   context "schedule queries" do
#     pending "#schedule_by_route"
#     pending "#schedule_by_stop"
#     pending "#schedule_by_trip"
#   end


#   context "prediction and vehicle location queries" do
#     pending "#predictions_by_route"
#     pending "#predictions_by_stop"
#     pending "#predictions_by_trip"
#     pending "#vehicles_by_route"
#     pending "#vehicles_by_trip"
#   end


#   context "alert queries" do
#     pending "haven't even written what tests will go here"
#   end
