# frozen_string_literal: true

class HandDeck
  def initialize
    @cards = []
  end

  def deck=(deck)
    @deck = deck if @deck.nil?
  end

  def take_a_card
    @cards << @deck.take_a_card
  end

  def push_cards
    @cards.each { |card| @deck.push_a_card(card) }
    @cards = []
  end

  def to_s
    @cards.map(&:to_s).join(', ')
  end

  def points
    points = @cards.map(&:points).sum
    ace = @cards.map { |card| card.points == 11 ? 1 : 0 }.sum
    while points > 21 && ace > 0
      points -= 10
      ace -= 1
    end
    points
  end

  def cards_count
    @cards.count
  end
end
