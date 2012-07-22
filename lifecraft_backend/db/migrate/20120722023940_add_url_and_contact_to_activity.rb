class AddUrlAndContactToActivity < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.string :url
    end
  end
end
