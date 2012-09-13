class CreatePrecoProdutos < ActiveRecord::Migration
  def change
    create_table :preco_produtos do |t|
      t.references :produto
      t.date :vigencia
      t.decimal :preco, :precision => 8, :scale => 2
      t.boolean :ativo
      t.timestamps
    end
    
   #add_index :preco_produtos, [:produto, :vigencia], :unique => true
    
  end
end
