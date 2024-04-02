class CreateTours < ActiveRecord::Migration[7.1]
  def change
    create_table :tours do |t|
      t.string :name
      t.references :operator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
