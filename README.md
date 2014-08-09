# mbta-realtime

Description goes here.

## Usage

Remember to always require 'mbta-realtime' before you use it.

```ruby
require 'mbta-realtime' # 'mbta_realtime' also works
```


Initialize it with your API key.

```ruby
@mbta = MBTARealtime.new("your_api_key")
# or
@mbta = MBTARealtime.new(api_key: "your_api_key")
```

If you keep your API key in an environment variable (or .env file with [Dotenv](https://github.com/bkeepers/dotenv)), such as

```
export MBTA_API_KEY=wu9RGmG7OoT2UZnHuwN9Xw
```

you can initialize your MBTA Realtime client with

```ruby
@mbta = MBTARealtime.new(ENV['MBTA_API_KEY'])
```



### API Mirror

Most of the methods mirror those of the API, which is convenient when 

@mbta.stops_by_location


### 


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

