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
      eager_load_cards = lookahead.selection(:nodes).selects?(:cards) ||
        lookahead.selection(:edges).selection(:node).selects?(:cards)

      return ::Deck.where(id: id) unless id.nil?
      
      return ::Deck.all.eager_load(:cards) if type.nil? && eager_load_cards
      return ::Deck.all.eager_load(:cards) if type.nil?

      return ::Deck.where(kind: type).eager_load(:cards) if eager_load
      ::Deck.where(kind: type)
    end
  end
end
