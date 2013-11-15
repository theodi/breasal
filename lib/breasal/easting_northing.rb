module Breasal
  
  class EastingNorthing
    
    include Breasal::Utils
    
    def initialize(options)
      @easting = options[:easting]
      @northing = options[:northing]
      @type = options[:type] || :gb
    end
    
    # Takes OSGB36 or TM75 (Irish national grid) Easting/Northing coords 
    # and returns WGS84 Latitude and Longitude
    def to_wgs84
      ll = to_latlng(@easting, @northing, @type)
      lat_lng = LatLng.new(latitude: ll[:latitude], longitude: ll[:longitude], type: @type)
      lat_lng.to_WGS84
    end

    # Takes OSGB36 or TM75 (Irish national grid) Easting/Northing coords
    # and returns Latitude and Longitude in either OSGB36 or TM75 format
  	def to_latlng(easting, northing, type = :gb)

  	    if type == :ie
          @OSGB_F0  = 1.000035
          @N0       = 250000.0
          @E0       = 200000.0
          @phi0     = deg_to_rad(53.5)
          @lambda0  = deg_to_rad(-8.0)
          @a        = 6377340.189
          @b        = 6356034.447
        else
          @OSGB_F0  = 0.9996012717
          @N0       = -100000.0
          @E0       = 400000.0
          @phi0     = deg_to_rad(49.0)
          @lambda0  = deg_to_rad(-2.0)
          @a        = 6377563.396
          @b        = 6356256.909
        end 

        @eSquared = ((@a * @a) - (@b * @b)) / (@a * @a)
        @phi      = 0.0
        @lambda   = 0.0
        @E        = easting
        @N        = northing
        @n        = (@a - @b) / (@a + @b)
        @M        = 0.0
        @phiPrime = ((@N - @N0) / (@a * @OSGB_F0)) + @phi0

  	     begin

  	       @M =
  	         (@b * @OSGB_F0)\
  	           * (((1 + @n + ((5.0 / 4.0) * @n * @n) + ((5.0 / 4.0) * @n * @n * @n))\
  	             * (@phiPrime - @phi0))\
  	             - (((3 * @n) + (3 * @n * @n) + ((21.0 / 8.0) * @n * @n * @n))\
  	               * Math.sin(@phiPrime - @phi0)\
  	               * Math.cos(@phiPrime + @phi0))\
  	             + ((((15.0 / 8.0) * @n * @n) + ((15.0 / 8.0) * @n * @n * @n))\
  	               * Math.sin(2.0 * (@phiPrime - @phi0))\
  	               * Math.cos(2.0 * (@phiPrime + @phi0)))\
  	             - (((35.0 / 24.0) * @n * @n * @n)\
  	               * Math.sin(3.0 * (@phiPrime - @phi0))\
  	               * Math.cos(3.0 * (@phiPrime + @phi0))))

  	       @phiPrime += (@N - @N0 - @M) / (@a * @OSGB_F0)

  	     end while ((@N - @N0 - @M) >= 0.001)

  	     @v = @a * @OSGB_F0 * ((1.0 - @eSquared * sin_pow_2(@phiPrime)) ** -0.5)
  	     @rho =
  	       @a\
  	         * @OSGB_F0\
  	         * (1.0 - @eSquared)\
  	         * ((1.0 - @eSquared * sin_pow_2(@phiPrime)) ** -1.5)
  	     @etaSquared = (@v / @rho) - 1.0
  	     @VII = Math.tan(@phiPrime) / (2 * @rho * @v)
  	     @VIII =
  	       (Math.tan(@phiPrime) / (24.0 * @rho * (@v ** 3.0)))\
  	         * (5.0\
  	           + (3.0 * tan_pow_2(@phiPrime))\
  	           + @etaSquared\
  	           - (9.0 * tan_pow_2(@phiPrime) * @etaSquared))
  	     @IX =
  	       (Math.tan(@phiPrime) / (720.0 * @rho * (@v ** 5.0)))\
  	         * (61.0\
  	           + (90.0 * tan_pow_2(@phiPrime))\
  	           + (45.0 * tan_pow_2(@phiPrime) * tan_pow_2(@phiPrime)))
  	     @X = sec(@phiPrime) / @v
  	     @XI =
  	       (sec(@phiPrime) / (6.0 * @v * @v * @v))\
  	         * ((@v / @rho) + (2 * tan_pow_2(@phiPrime)))
  	     @XII =
  	       (sec(@phiPrime) / (120.0 * (@v ** 5.0)))\
  	         * (5.0\
  	           + (28.0 * tan_pow_2(@phiPrime))\
  	           + (24.0 * tan_pow_2(@phiPrime) * tan_pow_2(@phiPrime)))
  	     @XIIA =
  	       (sec(@phiPrime) / (5040.0 * (@v ** 7.0)))\
  	         * (61.0\
  	           + (662.0 * tan_pow_2(@phiPrime))\
  	           + (1320.0 * tan_pow_2(@phiPrime) * tan_pow_2(@phiPrime))\
  	           + (720.0\
  	             * tan_pow_2(@phiPrime)\
  	             * tan_pow_2(@phiPrime)\
  	             * tan_pow_2(@phiPrime)))
  	     @phi =
  	       @phiPrime\
  	         - (@VII * ((@E - @E0) ** 2.0))\
  	         + (@VIII * ((@E - @E0) ** 4.0))\
  	         - (@IX * ((@E - @E0) ** 6.0))
  	     @lambda =
  	       @lambda0\
  	         + (@X * (@E - @E0))\
  	         - (@XI * ((@E - @E0) ** 3.0))\
  	         + (@XII * ((@E - @E0) ** 5.0))\
  	         - (@XIIA * ((@E - @E0) ** 7.0))

  	    { :latitude => rad_to_deg(@phi), :longitude => rad_to_deg(@lambda) }

  	  end
    
  end
  
end