# frozen_string_literal: true

require './player.rb'

class Dealer
  include Player

  def print_hidden_deck
    ' *' * cards_count
  end

  def print_deck
    @hand_deck.to_s
  end

  def turn
    take_a_card if points < 17 && cards_count < 3
  end
end
