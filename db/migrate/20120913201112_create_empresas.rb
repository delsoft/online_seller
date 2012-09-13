class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :nome
      t.string :logo
      t.references :grupo_empresa
      t.timestamps
    end
  end
end
