class CreateDisps < ActiveRecord::Migration
  def change
    create_table :disps do |t|

      t.timestamps
    end
  end
end
