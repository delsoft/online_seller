class CreateFornecedor < ActiveRecord::Migration
  def change
    create_table :fornecedor do |t|
      t.string :nome
      t.timestamps
    end
  end
end
