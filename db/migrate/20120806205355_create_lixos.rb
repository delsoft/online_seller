class CreateLixos < ActiveRecord::Migration
  def change
    create_table :lixo do |t|

      t.timestamps
    end
  end
end
