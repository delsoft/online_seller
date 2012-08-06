class CreateTipoUnidadeMedidas < ActiveRecord::Migration
  def change
    create_table :tipo_unidade_medidas do |t|
      t.string :nome
      t.string :nome_abreviado
      t.string :formato      

      t.timestamps
    end
  end
end
