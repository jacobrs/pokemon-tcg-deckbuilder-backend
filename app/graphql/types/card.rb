module Types
  class Card < Types::BaseObject

    field :id, Integer, null: false, description: "Return the id of the card."
    field :name, String, null: false, description: "Return the name of the card."
    field :image_url, String, null: true, description: "Return the image url of the card."
    field :tcg_api_id, String, null: false, description: "Return the card id from the pokemon tcg api."
    field :evolves_from, String, null: true, description: "Return the pokemon this one evolves from."
    field :rarity, String, null: true, description: "Return how rare the card is."
    field :average_price, String, null: true, description: "Return the average selling price in USD."
    
    field :super_type, String, null: false, description: "Return the card supertype (E.g. Pokemon, Energy, Trainer)"
    def super_type
      object.supertype
    end

    field :type, PokemonType, null: true, description: "Return the type of the card."
    def type
      object.kind
    end

  end
end
