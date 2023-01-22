module Types
  module Inputs
    class GenerateDeckInput < Types::BaseInputObject
      description "Attributes for generating a new deck."
      
      argument :name, String, "Name of the deck."
      argument :type, ::Types::PokemonType, "Type of the deck to be generated."
      argument :pool_size, Integer, required: false,
        description: "Number of cards to add to the random pool for generation, larger values will take more time to generate."
    end
  end
end
