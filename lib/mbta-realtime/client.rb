require 'geocoder'

module MBTARealtime
  class Client
    include HTTParty

    attr_reader :api_key, :format
  
    base_uri 'realtime.mbta.com/developer/api/v2'
    
    def initialize(args={})
      @api_key = args.fetch(:api_key) { args }
      @format  = args.fetch(:format)  { "json" }

      @options = {query: { api_key: @api_key, format: @format }}
      @options.freeze
    end


    # Routes


    def routes
      self.class.get("/routes", @options).to_h
    end

    
    def routes_by_stop(stop_id)
      self.class.get("/routesbystop", url_opts({stop: stop_id})).to_h
    end


    # Stops


    def stop_name(stop_id)
      self.class.get("/schedulebystop", url_opts({stop: stop_id})).to_h["stop_name"]
    end


    def stops_by_route(route_id)
      self.class.get("/stopsbyroute", url_opts({route: route_id})).to_h
    end


    def stops_by_location(location={})
      # Requires a hash {lat: 42.35291,lon: -71.064648}
      self.class.get("/stopsbylocation", url_opts( location )).to_h
    end


    def nearest_stop(location={})
      stops_by_location(location)["stop"].first
    end


    def nearest_stop_id(location={})
      nearest_stop(location)["stop_id"]
    end


    def stops_by_location_name(intersection)
      lat, lng = Geocoder.coordinates(intersection)
      stops_by_location(lat: lat, lon: lng)
    end

    
    def nearest_stop_by_location_name(intersection)
      stops_by_location_name(intersection)["stop"].first
    end


    def nearest_stop_id_by_location_name(intersection)
      nearest_stop_by_location_name(intersection)["stop_id"]
    end


    def predictions_by_stop(stop_id, flatten=false)
      ps = self.class.get("/predictionsbystop", url_opts({stop: stop_id})).to_h
      flatten ? flatten_predictions(ps) : ps
    end


    def predictions_by_stop_and_route(stop_id, route_ids)
      preds = predictions_by_stop(stop_id)
      rids  = route_ids.map {|i| i.to_s }
      
      return preds if rids.empty?

      preds['mode'].each do |mode|
        # Keep only predictions that are within the route ID
        mode['route'].keep_if { |route| rids.include?(route['route_name']) }
      end

      preds
    end


    def flat_complex_predictions(stop_id, route_ids)
      flatten_predictions(predictions_by_stop_and_route(stop_id, route_ids))
    end


    def predictions_by_route(route_id)
      raise NotImplementedError
    end


    def predictions_by_location_name(intersection, flatten=false)
      ps = predictions_by_stop( nearest_stop_id_by_location_name(intersection) )
      flatten ? flatten_predictions( ps ) : ps
    end



    private

      def url_opts(args={})
        { query: @options[:query].merge( args ) }
      end

      def flatten_predictions(predictions_response)
        @predictions = []

        travel_modes = predictions_response['mode']
        travel_modes.each do |mode|
          routes = mode['route']
          routes.each do |route|
            route_obj  = OpenStruct.new(id: route['route_id'], name: route['route_name'], trips: [])
            directions = route['direction']
            directions.each do |dir|
              trips = dir['trip']
              trips.each do |trip|
                route_obj.trips << OpenStruct.new(id:    trip['trip_id'],
                                                  time:  trip['pre_away'])
              end
            end

            @predictions << route_obj
          end
        end
        @predictions
      end

  end
end

    #   def assert_api_key
    #     unless @api_key
    #       raise ArgumentError, %Q{ You must pass an API key, i.e.:
    #       MBTARealtime.new(<your_api_key>). If you do not have an API
    #       key, please register for an account with the MBTA-realtime
    #       Developer Portal at http://realtime.mbta.com/Portal/Account/Register. }
    #     end
    #   end

    
