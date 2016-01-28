class CreatePricePoints < ActiveRecord::Migration
  def change
    create_table :price_points do |t|
      t.decimal :price
      t.datetime :datetime
      t.references :flight, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
