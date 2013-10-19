class CreateDatapages < ActiveRecord::Migration
  def change
    create_table :datapages do |t|
      t.string :url
      t.text :html

      t.timestamps
    end
  end
end
