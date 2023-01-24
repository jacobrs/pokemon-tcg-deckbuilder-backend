module Types
  class PokemonType < Types::BaseEnum
    graphql_name "PokemonType"
    description "Supported pokemon and energy card types."

    value "COLORLESS",  value: "Colorless"
    value "DARKNESS",  value: "Darkness"
    value "DRAGON",  value: "Dragon"
    value "FAIRY",  value: "Fairy"
    value "FIGHTING",  value: "Fighting"
    value "FIRE",  value: "Fire"
    value "GRASS",  value: "Grass"
    value "LIGHTNING",  value: "Lightning"
    value "METAL",  value: "Metal"
    value "PSYCHIC",  value: "Psychic"
    value "WATER",  value: "Water"
  end
end
