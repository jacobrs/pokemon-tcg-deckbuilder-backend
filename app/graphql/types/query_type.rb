module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :decks, [Types::Deck], null: false, description: "List of all decks generated." do
      argument :type, PokemonType, required: false
    end

    def decks(type: nil)
      ::Deck.all
    end
  end
end
