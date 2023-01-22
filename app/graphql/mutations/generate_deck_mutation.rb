module Mutations
  class GenerateDeckMutation < BaseMutation
    
    argument :attributes, Types::Inputs::GenerateDeckInput

    field :deck, Types::Deck, null: true
    field :errors, [String], null: false

    def resolve(input)
      attributes = input[:attributes]
      builder = Services::DeckBuilder.new(attributes.type, attributes[:name])
      deck = builder.generate
      deck.save

      {
        deck: deck,
        errors: [],
      }

    rescue Exception => e
      {
        deck: nil,
        errors: [e.message],
      }
    end
  end
end
