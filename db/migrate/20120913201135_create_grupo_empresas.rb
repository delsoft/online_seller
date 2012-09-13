class CreateGrupoEmpresas < ActiveRecord::Migration
  def change
    create_table :grupo_empresas do |t|
      t.string :nome
      t.string :logo
      
      t.timestamps
    end
  end
end
