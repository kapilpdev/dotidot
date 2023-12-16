class CreateScrapers < ActiveRecord::Migration[7.0]
  def change
    create_table :scrapers do |t|
      t.string :url
      t.text :fields

      t.timestamps
    end
  end
end
