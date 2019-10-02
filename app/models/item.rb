class Item < ApplicationRecord
    belongs_to :merchant
    has_many :invoice_items
    has_many :invoices, through: :invoice_items

    validates_presence_of :name, :description, :unit_price, :merchant_id

    def best_day
        dates = ActiveRecord::Base.connection.execute("select count(*), date(invoices.created_at) from invoice_items inner join invoices on invoice_items.invoice_id = invoices.id inner join transactions on invoices.id = transactions.invoice_id where item_id = #{self.id} and transactions.result = 'success' group by date(invoices.created_at) order by count(*) desc, date(invoices.created_at) desc limit 1")
        dates.values.flatten.last
    end
end
