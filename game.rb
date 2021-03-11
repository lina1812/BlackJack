# frozen_string_literal: true

require './dealer.rb'
require './deck.rb'
require './user.rb'

# menu
class Game
  def initialize
    @dealer = Dealer.new
    @deck = Deck.new
    @dealer.deck = @deck
    @game_bank = 0
  end

  def create_user(name)
    @user = User.new(name)
    @user.deck = @deck
  end

  def start_game
    @deck.shuffle!
    2.times do
      @user.take_a_card
      @dealer.take_a_card
    end

    @game_bank += @user.place_a_bet
    @game_bank += @dealer.place_a_bet

    data = {
      banks: {
        user: @user.bank,
        dealer: @dealer.bank
      },
      decks: {
        user_deck: @user.print_deck,
        dealer_hidden_deck: @dealer.print_hidden_deck

      }
    }

    data
  end

  def skip_turn
    @dealer.turn
  end

  def take_a_card
    @user.take_a_card if @user.cards_count == 2
    @dealer.turn
  end

  def open_cards
    @dealer.turn
  end

  def can_take_card?
    @user.cards_count == 2
  end

  def can_start_new_round?
    @user.bank < Player::BET_AMOUNT || @dealer.bank < Player::BET_AMOUNT
  end

  def user_points
    @user.points
  end

  def finish_game
    data = {
      user_deck: @user.print_deck,
      dealer_deck: @dealer.print_deck,
      user_points: @user.points,
      dealer_points: @dealer.points
    }
    if @user.points <= 21 && ((@user.points >  @dealer.points) || (@dealer.points > 21))
      data[:winner] = :user
      @user.add_to_bank(@game_bank)
    elsif @dealer.points <= 21 && @user.points != @dealer.points
      data[:winner] = :dealer
      @dealer.add_to_bank(@game_bank)
    else
      data[:winner] = :nobody
      @user.add_to_bank(@game_bank / 2)
      @dealer.add_to_bank(@game_bank / 2)
    end
    @game_bank = 0
    @user.push_cards
    @dealer.push_cards
    data
  end
end
