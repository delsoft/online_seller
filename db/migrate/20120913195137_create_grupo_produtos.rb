class CreateGrupoProdutos < ActiveRecord::Migration
  def change
    create_table :grupo_produtos do |t|
      t.references :empresa
      t.string :parent_id
      
      t.string :nome
      t.string :descricao

      t.timestamps
    end
  end
end
