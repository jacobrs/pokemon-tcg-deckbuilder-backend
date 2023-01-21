module Types
  class Deck < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :id, Integer, null: false, description: "Return the id of the deck."
    field :name, String, null: false, description: "Return the name of the deck."

    field :type, PokemonType, null: false, description: "Return the type of the deck."
    def type
      object.kind
    end

    field :cards, [Types::Card], null: false, description: "Return a list of cards in the deck."
    def items
      object.cards.all
    end 
  end
end
