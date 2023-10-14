class CreatePedidos < ActiveRecord::Migration[7.0]
  def change
    create_table :pedidos do |t|
      t.references :recetum, null: false, foreign_key: true
      t.string :estado

      t.timestamps
    end
  end
end
