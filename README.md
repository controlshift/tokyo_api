# tokyo\_api

A ruby gem for communicating with ControlShift's Tokyo API.

[![CI Status](https://github.com/controlshift/tokyo_api/actions/workflows/ci.yml/badge.svg)](https://github.com/controlshift/tokyo_api/actions/workflows/ci.yml)

## Usage

```ruby
ta = TokyoApi.new(host: 'localhost:9000', username: 'tokyo', password: 'Passw0rd!', scheme: 'http', timeout: 5)
ta.organisation.expire('foo.com')
```

## Copyright

Copyright (c) 2013 Nathan Woodhull. See LICENSE.txt for
further details.

