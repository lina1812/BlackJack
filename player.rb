# frozen_string_literal: true

require 'forwardable'
require './hand_deck.rb'

module Player
  extend Forwardable
  START_BANK = 100
  BET_AMOUNT = 10
  attr_reader :bank

  def self.included(base)
    base.prepend Initializer
  end

  module Initializer
    def initialize(*arg)
      super(*arg)
      @bank = START_BANK
      @hand_deck = HandDeck.new
    end
  end

  def place_a_bet
    raise 'Not enough money!' if @bank < BET_AMOUNT

    @bank -= BET_AMOUNT
    BET_AMOUNT
  end

  def add_to_bank(money)
    @bank += money
  end

  def deck=(deck)
    @hand_deck.deck = deck
  end

  def_delegators :@hand_deck, :take_a_card, :push_cards, :points, :cards_count
end
