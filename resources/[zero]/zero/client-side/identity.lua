local registration_number = "00AAA000"

zero.setRegistrationNumber = function(registration)
	registration_number = registration
end

zero.getRegistrationNumber = function()
	return registration_number
end