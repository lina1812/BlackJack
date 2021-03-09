# frozen_string_literal: true

require './dealer.rb'
require './deck.rb'
require './user.rb'

# menu

puts 'What is your name?'
name = gets.chomp
@user = User.new(name)
@dealer = Dealer.new
@deck = Deck.new

@user.deck = @deck
@dealer.deck = @deck

@game_bank = 0

puts "Hello #{@user.name}"

def start_game
  puts 'Starting a new game...'
  @deck.shuffle!
  2.times do
    @user.take_a_card
    @dealer.take_a_card
  end

  @game_bank += @user.place_a_bet
  @game_bank += @dealer.place_a_bet

  @user.print_deck
  @dealer.print_hidden_deck

  puts 'Your bank  \ Dealer bank \ Game bank'
  puts "#{@user.bank}  \ #{@dealer.bank} \ #{@game_bank}"
end

def print_actions
  puts "Your points : #{@user.points}"
  puts 'Enter 0 to skip your turn'
  puts 'Enter 1 to take a capd' if @user.cards_count == 2
  puts 'Enter 2 to open cards'
end

def finish_game
  puts 'Finish game'
  @user.print_deck
  @dealer.print_deck
  puts 'Your points  \ Dealer points'
  puts "#{@user.points}  \ #{@dealer.points}"
  if @user.points <= 21 && ((@user.points >  @dealer.points) || (@dealer.points > 21))
    puts 'You won!'
    @user.add_to_bank(@game_bank)
  elsif @dealer.points <= 21 && @user.points != @dealer.points
    puts 'You lose!'
    @dealer.add_to_bank(@game_bank)
  else
    puts 'Dead heat'
    @user.add_to_bank(@game_bank / 2)
    @dealer.add_to_bank(@game_bank / 2)
  end
  @game_bank = 0
  @user.push_cards
  @dealer.push_cards
end

def ask_next_game
  return false if @user.bank < Player::BET_AMOUNT || @dealer.bank < Player::BET_AMOUNT

  puts 'Do you want to continue playing? Yes / No '
  case gets.chomp
  when 'Yes'
    true
  when 'No'
    false
  end
end

loop do
  start_game
  loop do
    print_actions
    case gets.chomp.to_i
    when 0
      @dealer.turn
    when 1
      @user.take_a_card if @user.cards_count == 2
      @dealer.turn
      break
    when 2
      @dealer.turn
      break
    end
  end
  finish_game
  break unless ask_next_game
end
