class CreatePesquisa < ActiveRecord::Migration
  def change
    create_table :pesquisa do |t|
      t.string :palavra
      t.string :match_code, :limit => 4
      t.references

      t.timestamps
    end
  end
end
