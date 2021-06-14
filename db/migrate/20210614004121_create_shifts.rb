class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.datetime :time_start
      t.datetime :time_end
      t.string :position
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
