class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.references :tour, null: false, foreign_key: true
      t.date :available_from
      t.date :available_until
      t.integer :length
      t.integer :day_of_week
      t.integer :day_of_week_index
      t.boolean :recurring

      t.timestamps
    end

    add_index :schedules, [:available_from, :available_until]
  end
end
