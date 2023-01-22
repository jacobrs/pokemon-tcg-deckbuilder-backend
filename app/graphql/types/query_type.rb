module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :decks, Types::Deck.connection_type, null: false,
      description: "List of all decks generated.", extras: [:lookahead] do
      argument :type, PokemonType, required: false
      argument :id, Integer, required: false
    end

    def decks(type: nil, id: nil, lookahead: nil)
      return ::Deck.where(id: id) unless id.nil?
      return ::Deck.all.eager_load(:cards) if type.nil?

      ::Deck.where(kind: type).eager_load(:cards)
    end
  end
end
