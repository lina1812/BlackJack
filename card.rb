# frozen_string_literal: true

class Card
  SUITS = ['+', '^', '<3', '<>'].freeze
  VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize(value, suit)
    @value = value
    @suit = suit
    validate!
  end

  def to_s
    "#{@value} #{@suit}"
  end

  def points
    return 10 if %w[K J Q].include?(@value)
    return 11 if @value == 'A'

    @value.to_i
  end

  def validate!
    raise 'Incorrect card value' unless VALUES.include?(@value)
    raise 'Incorrect card suit' unless SUITS.include?(@suit)
  end
end
