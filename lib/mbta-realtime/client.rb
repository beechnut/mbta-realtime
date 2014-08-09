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


    def predictions_by_stop(stop_id)
      raise NotImplementedError
    end


    def predictions_by_route(route_id)
      raise NotImplementedError
    end


    def predictions_by_location(location)
      raise NotImplementedError
    end


    def predictions_by_location_name(intersection)
      raise NotImplementedError
    end



    private

      def url_opts(args={})
        { query: @options[:query].merge( args ) }
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

    
