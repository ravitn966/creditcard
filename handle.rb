require 'card.rb'

commands = ARGV[0].split("\n")

@cards = {}

puts "\nProcessing...\n"

def get_card name
	card = @cards[name] 
	card || raise("Card not found")
end

def textamount_to_cents text
	text[1..-1].to_f * 100
end

commands.each {|command|
  args = command.split(' ')
  
  begin
    case args[0]
      when 'Add'
        @cards[args[1]] = Card.new(args[1], args[2], textamount_to_cents(args[3]))
      when 'Charge' 
        card = get_card(args[1])
        card.change_balance -textamount_to_cents(args[2])
      when 'Credit'
        card = get_card(args[1])
        card.change_balance textamount_to_cents(args[2])
      else
        raise "Unknown command"
    end
  rescue RuntimeError => error
    puts "Error:  #{command} -> #{error}"
  end
}

puts "\nDone!\n"

puts @cards.sort.map{|name, card| card.status }