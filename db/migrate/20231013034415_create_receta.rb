class CreateReceta < ActiveRecord::Migration[7.0]
  def change
    create_table :receta do |t|
      t.string :nombre
      t.string :ingredientes
      t.string :cantidades

      t.timestamps
    end
  end
end
