# frozen_string_literal: true

require './card.rb'

class Deck
  def initialize
    create_cards
  end

  def take_a_card
    @cards.pop
  end

  def push_a_card(card)
    @cards << card unless @cards.include?(card)
  end

  def shuffle!
    @cards.shuffle!
  end

  private

  def create_cards
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        @cards << Card.new(value, suit)
      end
    end
  end
end
