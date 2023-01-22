module Services
  class DeckBuilder
    MAXIMUM_DECK_SIZE = 60
    NUMBER_OF_POKEMON_TYPES = 12..16
    NUMBER_OF_ENERGY_CARDS = 10
    NUMBER_OF_ALLOWED_DUPLICATED = 4

    def initialize(type, name)
      throw "No type given for deck generation" if type.nil?
      throw "No name given for deck generation" if name.nil?
      @type = type
      @name = name
    end

    def generate
      number_of_pokemon_types = rand(NUMBER_OF_POKEMON_TYPES)
      number_of_trainer_cards = MAXIMUM_DECK_SIZE - NUMBER_OF_ENERGY_CARDS - number_of_pokemon_types

      cards = generate_pokemon_cards(number_of_pokemon_types) + generate_energy_cards + generate_trainer_cards(number_of_trainer_cards)

      deck = Deck.create(
        name: @name,
        kind: @type
      )

      deck.cards = cards
      deck
    end

    private

    def generate_pokemon_cards(amount_to_generate)
      pokemon_of_type_card_pool = Pokemon::Card.where(q: "types:#{@type} supertype:Pokémon", page: 1, pageSize: 100)
      take_cards_from_pool(pokemon_of_type_card_pool, amount_to_generate)
    end

    def generate_energy_cards
      energy_of_type_card_pool = Pokemon::Card.where(q: "name:#{@type} supertype:Energy", page: 1, pageSize: 100)
      take_cards_from_pool(energy_of_type_card_pool, NUMBER_OF_ENERGY_CARDS)
    end

    def generate_trainer_cards(amount_to_generate)
      trainer_of_type_card_pool = Pokemon::Card.where(q: "supertype:Trainer", page: 1, pageSize: 100)
      take_cards_from_pool(trainer_of_type_card_pool, amount_to_generate)
    end

    def take_cards_from_pool(card_pool, number_of_cards_to_take)
      cards = []
      size_of_card_pool = card_pool.size
      while cards.size < number_of_cards_to_take
        random_card = card_pool[rand(0..size_of_card_pool-1)]

        next unless less_than_allowed_duplicates(cards, random_card)

        cards.push(Card.new(
          name: random_card.name,
          supertype: random_card.supertype,
          kind: random_card.supertype == "Trainer" ? nil : @type,
          image_url: random_card.images.small,
          tcg_api_id: random_card.id
        ))
      end

      cards
    end

    def less_than_allowed_duplicates(cards, card)
      cards.count do |c|
        c.tcg_api_id == card.id
      end < NUMBER_OF_ALLOWED_DUPLICATED
    end
  end
end
