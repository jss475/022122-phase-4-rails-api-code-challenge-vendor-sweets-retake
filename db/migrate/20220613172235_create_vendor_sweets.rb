class CreateVendorSweets < ActiveRecord::Migration[6.1]
  def change
    create_table :vendor_sweets do |t|
      t.integer :price
      t.integer :vendor_id
      t.integer :sweet_id

      t.timestamps
    end
  end
end
