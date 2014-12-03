	require 'date'
require 'time'
class BusinessHours
	attr_accessor :workingsec
	attr_reader	:exceptions
	def initialize(starttime, endtime)
		@defaultstartendtime = [DateTime.parse(starttime), DateTime.parse(endtime)]
		@exceptions = Hash.new(0)
	end

	def update(day, starttime, endtime)
		#exceptionworkingsec = getSecondsFromTime(starttime, endtime)
		@exceptions[day] = [DateTime.parse(starttime), DateTime.parse(endtime)]
	end

	def closed(*days)
		days.each { |e| @exceptions[e] = [DateTime.parse("12:00 AM"), DateTime.parse("12:00 AM")] }
	end

	def calculate_deadline(seconds, day)

		day = DateTime.parse(day) if day.is_a? String
		# Need to find out why this cant be combined in a single line
		currentworkingduration = @exceptions[day.strftime('%b %-d, %Y')]
		currentworkingduration = @exceptions[day.strftime('%a').downcase.to_sym] if currentworkingduration == 0
		currentworkingduration =  @defaultstartendtime if currentworkingduration == 0
		currentworkingsec = getWorkingSec(day, currentworkingduration)
		#Make day start at starttime of the day if it is less than the starttime
		difference = getSecondsFromTime(DateTime.parse(day.strftime('%l:%M %p')), currentworkingduration[0])
		day += Rational(difference, 86400) if difference > 0

		if currentworkingsec >= seconds
			day += Rational(seconds, 86400)
			return day.strftime('%a %b %-d, %Y %l:%M %p')
		else
			day += 1
			calculate_deadline(seconds - currentworkingsec, day.strftime('%b %-d, %Y'))
		end
	end

	private

	def getWorkingSec(day, duration)
		day = DateTime.parse(day.strftime('%l:%M %p'))
		starttime = duration[0]
		endtime =  duration[1]
		return 0 if starttime == endtime
		day = starttime if day < starttime
		return getSecondsFromTime(day, endtime) if day < endtime
		return 0
	end

	def getSecondsFromTime(starttime, endtime)
		Integer((endtime - starttime) * 24 * 60 * 60)
	end
end