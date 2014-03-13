[![Build Status](http://img.shields.io/travis/theodi/breasal.svg)](https://travis-ci.org/theodi/breasal)
[![Dependency Status](http://img.shields.io/gemnasium/theodi/breasal.svg)](https://gemnasium.com/theodi/breasal)
[![Coverage Status](http://img.shields.io/coveralls/theodi/breasal.svg)](https://coveralls.io/r/theodi/breasal)
[![Code Climate](http://img.shields.io/codeclimate/github/theodi/breasal.svg)](https://codeclimate.com/github/theodi/breasal)
[![Gem Version](http://img.shields.io/gem/v/breasal.svg)](https://rubygems.org/gems/breasal)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://theodi.mit-license.org)
[![Badges](http://img.shields.io/:badges-7/7-ff6799.svg)](https://github.com/pikesley/badger)

# Breasal

A Ruby gem that converts both British and Irish Eastings and northing to WGS84 latitude and longitude.

Based on the work by [Andrew Sprinz at Lambeth Council](https://github.com/LambethCouncil/OSGB36_Converter), and created in anger as part of work on [UK Postcodes](https://github.com/theodi/uk-postcodes)

Breasal is the Welsh and Cornish God of all earth, so I thought him suitably Celtic to cover all the British isles.

## Installation

Add this line to your application's Gemfile:

    gem 'breasal'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install breasal

## Usage

Provide an easting, northing and coordinate type (either `:gb` or `:ie` - default is `:gb`):

    en = Breasal::EastingNorthing.new(easting: 412617, northing: 308885, type: :gb)
  
Get the WGS84 latlng:

    en.to_wgs84 # => {:latitude=>52.67752501534847, :longitude=>-1.8148108086293673}

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

