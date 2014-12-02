class Polynomial
	def initialize(coeffarr)
		raise ArgumentError, "Too less coefficients" if coeffarr.count < 2
		@polynomial_print = ""
		power = coeffarr.count
		coeffarr.each do |e|
			power = power - 1 
			@polynomial_print << generate_polynomial(e, power) 
		end	
		@polynomial_print[0] = '' if @polynomial_print[0] == '+'
		puts @polynomial_print
	end

	private
	def generate_polynomial(coeff, power)
		return "" if coeff == 0
		addstring = ""
		addstring = "+" if coeff > 0
		coeff = String(coeff)
		power = String(power)
		return addstring << coeff if power == "0"
		if power == "1"
			power = ""
		else
			power = "^" + power
		end
		coeff = "" if coeff == "1"
		addstring << coeff << "x" << power
	end
end

