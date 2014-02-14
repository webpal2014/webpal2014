class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :kuvaus

      t.timestamps
    end
  end
end
