class AddMoreDetailColumnsToCards < ActiveRecord::Migration[7.0]
  def up
    add_column :cards, :rarity, :string
    add_column :cards, :average_price, :decimal, precision: 10, scale: 2
    add_column :cards, :evolves_from, :string
  end

  def down
    remove_column :cards, :rarity
    remove_column :cards, :average_price
    remove_column :cards, :evolves_from
  end
end
