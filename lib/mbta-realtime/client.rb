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


    def routes
      self.class.get("/routes", @options).to_h
    end

    
    def routes_by_stop(stop_id)
      self.class.get("/routesbystop", url_opts({stop: stop_id})).to_h
    end


    def stops_by_route(route_id)
      raise NotImplementedError
    end


    def stops_by_location(location)
      raise NotImplementedError
    end


    def stops_by_location_name(intersection)
      raise NotImplementedError
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

    
    # private

    #   def assert_api_key
    #     unless @api_key
    #       raise ArgumentError, %Q{ You must pass an API key, i.e.:
    #       MBTARealtime.new(<your_api_key>). If you do not have an API
    #       key, please register for an account with the MBTA-realtime
    #       Developer Portal at http://realtime.mbta.com/Portal/Account/Register. }
    #     end
    #   end

    
