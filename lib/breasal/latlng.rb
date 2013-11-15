module Breasal

  class LatLng
    
    include Breasal::Utils
    
    def initialize(options)
      @latitude = options[:latitude]
      @longitude = options[:longitude]
      @type = options[:type] || :gb
    end
    
	  # Takes OSGB36 or TM75 Latitude and Longitude coords 
    # and returns WGS84 Latitude and Longitude
	  def to_WGS84
	    
	    if @type == :ie
	      @a        = 6377340.189
	      @b        = 6356034.447
      else
        @a        = 6377563.396
        @b        = 6356256.909
      end
      
      @eSquared = ((@a * @a) - (@b * @b)) / (@a * @a)

      @phi = deg_to_rad(@latitude)
      @lambda = deg_to_rad(@longitude)
      @v = @a / (Math.sqrt(1 - @eSquared * sin_pow_2(@phi)))
      @H = 0
      @x = (@v + @H) * Math.cos(@phi) * Math.cos(@lambda)
      @y = (@v + @H) * Math.cos(@phi) * Math.sin(@lambda)
      @z = ((1 - @eSquared) * @v + @H) * Math.sin(@phi)

      @tx =        446.448
      @ty =       -124.157
      @tz =        542.060
      
      @s  =         -0.0000204894
      @rx = deg_to_rad( 0.00004172222)
      @ry = deg_to_rad( 0.00006861111)
      @rz = deg_to_rad( 0.00023391666)

      @xB = @tx + (@x * (1 + @s)) + (-@rx * @y)     + (@ry * @z)
      @yB = @ty + (@rz * @x)      + (@y * (1 + @s)) + (-@rx * @z)
      @zB = @tz + (-@ry * @x)     + (@rx * @y)      + (@z * (1 + @s))

      @a        = 6378137.000
      @b        = 6356752.3141
      @eSquared = ((@a * @a) - (@b * @b)) / (@a * @a)

      @lambdaB = rad_to_deg(Math.atan(@yB / @xB))
      @p = Math.sqrt((@xB * @xB) + (@yB * @yB))
      @phiN = Math.atan(@zB / (@p * (1 - @eSquared)))
      
      (1..10).each do |i|
        @v = @a / (Math.sqrt(1 - @eSquared * sin_pow_2(@phiN)))
        @phiN1 = Math.atan((@zB + (@eSquared * @v * Math.sin(@phiN))) / @p)
        @phiN = @phiN1
      end

      @phiB = rad_to_deg(@phiN)

      { :latitude => @phiB, :longitude => @lambdaB }
         
    end
  end

end