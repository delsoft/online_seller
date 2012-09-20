class CreateProdutos < ActiveRecord::Migration
  def change
    create_table :produtos do |t|
      t.string :nome
      t.references :grupo_produto
      t.references :empresa
      
      t.string :descricao

      t.timestamps
    end
  end
end
