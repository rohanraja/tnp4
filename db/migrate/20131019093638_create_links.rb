class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :pageno
      t.string :date
      t.text :html
      t.datetime :date_added

      t.timestamps
    end
  end
end
