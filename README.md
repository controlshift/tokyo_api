# tokyo_api

A ruby gem for communicating with ControlShift's Tokyo API.

[![Build Status](https://travis-ci.org/controlshift/tokyo_api.svg)](https://travis-ci.org/controlshift/tokyo_api)

## Usage

```ruby
ta = TokyoApi.new(host: 'localhost:9000', username: 'tokyo', password: 'Passw0rd!', scheme: 'http')
ta.organisation.expire('foo.com')
```

## Copyright

Copyright (c) 2013 Nathan Woodhull. See LICENSE.txt for
further details.

