class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.integer :origin_id
      t.integer :destination_id

      t.timestamps null: false
    end
  end
end
