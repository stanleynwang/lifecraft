class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.text :address
      t.float :longitude
      t.float :latitude
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps
    end
  end
end
