require 'test_helper'

class DeckBuilderTest < ActiveSupport::TestCase

  test "Cannot build without a name" do
    assert_raise do
      Services::DeckBuilder.new(nil, "Fire", nil)
    end
  end

  test "Cannot build without a type" do
    assert_raise do
      Services::DeckBuilder.new("Deck name", nil, nil)
    end
  end

  test "Can build without a pool_size" do
    assert_nothing_raised do
      Services::DeckBuilder.new("Deck name", "Fire", nil)
    end
  end

  test "Can generate 60 cards" do
    Pokemon::Card.stubs(:where).returns(sample_card_response)
    assert_nothing_raised do
      builder = Services::DeckBuilder.new("Deck name", "Fire", nil)
      deck = builder.generate
      assert_equal(60, deck.cards.size)
    end
  end

  def sample_card_response
    cards = []
    for i in 0..50 do
      cards << OpenStruct.new({
        id: i,
        name: "sample-card",
        supertype: "Energy",
        images: OpenStruct.new({
          small: "http://localhost/imageurl.png"
        }),
      })
    end
    cards
  end

end
