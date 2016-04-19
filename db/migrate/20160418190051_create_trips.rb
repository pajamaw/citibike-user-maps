class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :start_loc
      t.string :end_loc
      t.datetime :start_time
      t.datetime :end_time
      t.string :duration
      t.timestamps null: false
    end
  end
end
