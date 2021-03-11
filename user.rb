# frozen_string_literal: true

require './player.rb'

class User
  include Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def print_deck
    @hand_deck.to_s
  end
end
