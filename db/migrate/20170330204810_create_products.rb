class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.timestamps null: false
      t.string :product_code
    	t.integer :cost
    	t.integer :depot_id
    end
  end
end
