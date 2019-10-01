class Merchant < ApplicationRecord
    has_many :items
    has_many :invoices

    validates_presence_of :name

    def favorite_customer
        stuff = ActiveRecord::Base.connection.execute("select count(*), invoices.customer_id from transactions inner join invoices on transactions.invoice_id = invoices.id where invoices.merchant_id = #{self.id} group by invoices.customer_id order by count desc limit 1")
        stuff.values.flatten.last
    end
end
