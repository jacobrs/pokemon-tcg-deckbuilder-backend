require 'test_helper'

class QueryRootTest < ActiveSupport::TestCase
  test "load deck by ID" do
    query_string = <<-GRAPHQL
      query($id: Int){
        decks(id: $id) {
          nodes {
            name
            id
            type
          }
        }
      }
    GRAPHQL
  
    Deck.create({name: "Test Deck", kind: "Fire"})
    result = PokemonTcgBackendSchema.execute(query_string, variables: { id: Deck.first.id })
  
    deck_result = result["data"]["decks"]["nodes"].first
    
    assert_equal Deck.first.id, deck_result["id"]
    assert_equal "Test Deck", deck_result["name"]
    assert_equal "FIRE", deck_result["type"]
  end

  test "load deck by ID and get cards" do
    query_string = <<-GRAPHQL
      query($id: Int){
        decks(id: $id) {
          nodes {
            id
            cards{
              name
            }
          }
        }
      }
    GRAPHQL
  
    Deck.create({name: "Test Deck", kind: "Fire"})
    Deck.first.cards.create({name: "Test card", supertype: "Pokemon", tcg_api_id: "xy-1", image_url: "http://localhost/myimage.png"})
    result = PokemonTcgBackendSchema.execute(query_string, variables: { id: Deck.first.id })
  
    deck_result = result["data"]["decks"]["nodes"].first
    card_result = result["data"]["decks"]["nodes"].first["cards"][0]
    
    assert_equal Deck.first.id, deck_result["id"]
    assert_equal "Test card", card_result["name"]
  end

  test "load deck filters by type" do
    query_string = <<-GRAPHQL
      query($type: PokemonType){
        decks(type: $type) {
          nodes {
            name
            id
            type
          }
        }
      }
    GRAPHQL
  
    Deck.create({name: "Test Deck", kind: "Fire"})
    Deck.create({name: "Test Deck 2", kind: "Water"})
    Deck.create({name: "Test Deck 3", kind: "Metal"})
    Deck.create({name: "Test Deck 4", kind: "Fire"})
    result = PokemonTcgBackendSchema.execute(query_string, variables: { type: "FIRE" })
  
    assert_equal 2, result["data"]["decks"]["nodes"].count
  end

end
