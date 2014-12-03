require 'time'
class BusinessHours
	def initialize(starttime, endtime)
		@defaultstarttime = starttime
		@defaultendtime = endtime
		@exceptions = {
			:mon => [],
			:tue => [],
			:wed => [],
			:thu => [],
			:fri => [],
			:sat => [],
			:sun => [],
		}
	end

	def update(day, starttime, endtime)
	end

	def closed(day)
		
	end

	def calculate_deadline(seconds, day)
	end
end