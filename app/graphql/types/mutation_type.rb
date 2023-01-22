module Types
  class MutationType < Types::BaseObject
    field :generate_deck, mutation: Mutations::GenerateDeckMutation, description: "Generates a deck of 60 cards."
  end
end
