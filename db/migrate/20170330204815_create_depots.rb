class CreateDepots < ActiveRecord::Migration
  def change
    create_table :depots do |t|

      t.timestamps null: false
      t.string :depot_code 
    end
  end
end
