class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :kcal_per_100g

      t.timestamps
    end
  end
end
