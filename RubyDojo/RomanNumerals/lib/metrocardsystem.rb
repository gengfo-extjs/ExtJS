class MetroCard
	def initialize()
		@isInterChange = false
	end
	
	def setAmount(amount)
		@amount = amount;
	end

	def getAmount()
		@amount
	end
	
	def enter(stop, time)
		if (!@tripExitStop.nil? and isInterChange(stop, @tripExitStop) and within30Minutes(time, @tripExitTime))
			@isInterChange = true
		else
			@prevCost = 0 	
		end	
		@tripEnterStop = stop
		@tripEnterTime = time
	end
	
	def getIsInterchange
		@isInterChange
	end
	
	def isInterChange(stop1, stop2) 
		stop1.getIndex() == stop2.getIndex()
	end
	
	def within30Minutes(time1, time2)
		(time1 - time2).abs <= 30
	end
	
	def exit(stop, time)
		@tripExitStop = stop
		@tripExitTime = time
		
		currentAmount = @amount
		if (@isInterChange and calculateTripCost() > @prevCost) 
			@amount -= (calculateTripCost() - @prevCost)
		elsif !@isInterChange
			@amount -= calculateTripCost();	
		end
		@prevCost += (currentAmount - @amount)	
	end
	
	def calculateTripCost
		cost = 5;
		if (getTripDistance() <= 3)
			cost = 3
		elsif (getTripDistance() > 3 and getTripDistance() <= 8) 
			cost = 4	
		end
		cost
	end
	
	def getTripDistance
		(@tripEnterStop.getIndex - @tripExitStop.getIndex).abs
	end
end

class Stop
	def initialize()
		
	end
	
	def setIndex(index)
		@index = index;
	end
	
	def getIndex()
		@index
	end
end