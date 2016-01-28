class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.time :departure
      t.time :arrival
      t.string :number
      t.string :routing
      t.string :duration
      t.references :trend, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
