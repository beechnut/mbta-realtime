# MBTA Realtime

Description goes here.

## Usage

Remember to always require 'mbta-realtime' before you use it.

```ruby
require 'mbta-realtime' # 'mbta_realtime' also works
```


Initialize it with your API key.

```ruby
@mbta = MBTARealtime::Client.new(api_key: "your_api_key")
```

If you keep your API key in an environment variable (or .env file with [Dotenv](https://github.com/bkeepers/dotenv)), such as

```
export MBTA_API_KEY=wu9RGmG7OoT2UZnHuwN9Xw
```

you can initialize your MBTA Realtime client with

```ruby
@mbta = MBTARealtime.new(ENV['MBTA_API_KEY'])
```

All methods return Ruby hashes.

### Routes

`#routes` returns all the routes in the system.

```ruby
@mbta.routes
# => {"mode"=>[{"route_type"=>"0", "mode_name"=>"Subway", "route"=>[{"route_id"=>"810_", "route_name"=>"Green Line"}, {"route_id"=>"813_", "route_name"=>"Green Line"}
# ... rest truncated for brevity ...
```

`#routes_by_stop(stop_id)` returns all the routes for a given stop, indicated by its unique stop id.

```ruby
@mbta.routes_by_stop(1395)
# => {"stop_id"=>"1395", "stop_name"=>"Dartmouth St @ Appleton St", "mode"=>[{"route_type"=>"3", "mode_name"=>"Bus", "route"=>[{"route_id"=>"10", "route_name"=>"10"}, {"route_id"=>"170", "route_name"=>"170"}]}]} 
```


## Immediate Next Stops

+ Implement all to-be-implemented methods (already in the code, marked by the `NotImplementedError`s)
+ Improve the code / file structure. It's not great as-is. This is very early in development.
+ Set up smart, clean tests.
+ Assert and possibly test the API key provided
+ Instead of hashes, return value objects for `Stop`, `Route`, `Prediction`, etc., with other value objects nested within.




## Contributing to mbta-realtime
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 beechnut. See LICENSE.txt for
further details.

