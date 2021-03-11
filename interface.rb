# frozen_string_literal: true

require './game.rb'

class Interface
  def initialize
    @game = Game.new
  end

  def start_game
    introduction
    loop do
      start_round
      round_loop
      stop_round
      break unless ask_next_game
    end
  end

  def introduction
    puts 'What is your name?'
    name = gets.chomp
    @game.create_user(name)
    puts "Hello #{name}"
  end

  def start_round
    puts 'Starting a new game...'
    data = @game.start_game
    banks = data[:banks]
    decks = data[:decks]
    puts 'Your bank  \ Dealer bank \ Game bank'
    puts "#{banks[:user]}  \ #{banks[:dealer]} \ #{banks[:game]}"
    puts "Your deck : #{decks[:user_deck]}"
    puts "Your deck : #{decks[:user_deck]}"
  end

  def round_loop
    loop do
      print_actions
      case gets.chomp.to_i
      when 0
        @game.skip_turn
      when 1
        @game.take_a_card
        break
      when 2
        @game.open_cards
        break
      end
    end
  end

  def print_actions
    puts "Your points : #{@game.user_points}"
    puts 'Enter 0 to skip your turn'
    puts 'Enter 1 to take a capd' if @game.can_take_card?
    puts 'Enter 2 to open cards'
  end

  def stop_round
    puts 'Finish game'
    data = @game.finish_game
    puts "Your cards : #{data[:user_deck]}"
    puts "Dealer's cards : #{data[:dealer_deck]}"
    puts "Your points : #{data[:user_points]}"
    puts "Dealer points : #{data[:dealer_points]}"
    puts 'You won!' if data[:winner] == :user
    puts 'You lose!' if data[:winner] == :dealer
    puts 'Dead heat' if data[:winner] == :nobody
  end

  def ask_next_game
    return false if @game.can_start_new_round?

    puts 'Do you want to continue playing? Yes / No'
    case gets.chomp
    when 'Yes'
      true
    when 'No'
      false
    end
  end
end
