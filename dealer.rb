# frozen_string_literal: true

require './player.rb'

class Dealer
  include Player

  def print_hidden_deck
    puts "Dealer's cards :#{' *' * cards_count}"
  end

  def print_deck
    puts "Dealer's cards: #{@hand_deck}"
  end

  def turn
    take_a_card if points < 17 && cards_count < 3
  end
end
