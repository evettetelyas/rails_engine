require 'csv'

namespace :import do
  desc "Import Sales Engine"

  task all: :environment do
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
    end

    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end

    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      item = Item.create(row.to_h)
      item.update(unit_price: row["unit_price"].to_i * 0.01)
      item.save
    end

    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create(row.to_h)
    end

    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create(row.to_h)
    end

    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      ii = InvoiceItem.create(row.to_h)
      ii.update(unit_price: row["unit_price"].to_i * 0.01)
      ii.save
    end
  end

end
