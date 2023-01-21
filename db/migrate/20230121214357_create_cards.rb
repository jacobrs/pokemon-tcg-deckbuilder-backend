class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.bigint :deck_id
      t.string :name
      t.string :supertype
      t.string :type
      t.string :image_url
      t.string :tcg_api_id

      t.timestamps
    end
  end
end
