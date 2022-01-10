class Card
	def initialize(name, cardnumber, creditlimit = 0)		
		@name = name;
		@cardnumber = cardnumber;	
		@creditlimit = -creditlimit;
		@balance = 0;
		validate!
		return self
	end
	def validate!
		if @cardnumber.length > 20 
			raise "Card number may not be more than 19 digits long"
		elsif @cardnumber.length < 1
			raise "Card number must have at least one account digit and one checksum digit"
		end
		if @cardnumber.to_i.to_s != @cardnumber
			raise "Card number must contain only digits"
		end
		if @name.length < 1
			raise "Card name must not be blank" 
		end
		if Card.luhn_10(@cardnumber[0..-2]) != @cardnumber[-1..-1].to_i
			raise "Card number does not have valid Luhn 10 checksum"
		end 
	end
	def self.luhn_10 number
		double = true
		10 - number.reverse.split('').map(&:to_i).inject(0) {|sum, digit|
		  add = digit
      add *= 2 if double
      double = !double
	    sum += (add > 9 ? add -= 9 : add)
	  } % 10
	end
	
	def change_balance cents
		if (@balance + cents) < @creditlimit
			raise "Credit limit exceeded; charge declined"
		end
 		@balance += cents
	end
	
	def balance
	  @balance
	end
	
	def status
		 "#{@name}: $#{'%.2f' % (@balance / 100.0)}"
	end 
end