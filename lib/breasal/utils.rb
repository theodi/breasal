module Breasal

  module Utils    

    def deg_to_rad(degrees)
  	  degrees / 180.0 * Math::PI
  	end

  	def rad_to_deg(r)
  	  (r/Math::PI)*180
  	end

  	def sin_pow_2(x)
  	  Math.sin(x) * Math.sin(x)
  	end

  	def cos_pow_2(x)
  	  Math.cos(x) * Math.cos(x)
  	end

  	def tan_pow_2(x)
  	  Math.tan(x) * Math.tan(x)
  	end

  	def sec(x)
  	  1.0 / Math.cos(x)
  	end

  end

end