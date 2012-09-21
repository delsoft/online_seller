class CreatePreco < ActiveRecord::Migration
  def change
    create_table :preco do |t|
      t.references :produto      
      t.datetime :vigencia           
      t.timestamps
    end
  end
end
