# frozen_string_literal: true

require './player.rb'

class User
  include Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def print_deck
    puts "You card: #{@hand_deck}"
  end
end
