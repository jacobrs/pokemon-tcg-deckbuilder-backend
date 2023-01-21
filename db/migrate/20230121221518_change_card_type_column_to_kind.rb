class ChangeCardTypeColumnToKind < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :cards, :type, :kind
  end
  def self.down
    rename_column :cards, :kind, :type
  end
end
