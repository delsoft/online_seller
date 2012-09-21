class CreateProduto < ActiveRecord::Migration
  def change
    create_table :produto do |t|
      t.string :nome
      t.references :fornecedor
      t.timestamps
    end
  end
end
