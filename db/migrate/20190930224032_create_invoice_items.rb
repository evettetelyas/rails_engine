class CreateInvoiceItems < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_items do |t|
      t.references :item
      t.references :invoice
      t.integer :quantity
      t.decimal :unit_price

      t.timestamps
    end
  end
end
