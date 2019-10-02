class Merchant < ApplicationRecord
    has_many :items
    has_many :invoices

    validates_presence_of :name

    def favorite_customer
        stuff = ActiveRecord::Base.connection.execute("select count(*), invoices.customer_id from transactions inner join invoices on transactions.invoice_id = invoices.id where invoices.merchant_id = #{self.id} and transactions.result = 'success' group by invoices.customer_id order by count desc limit 1")
        stuff.values.flatten.last
    end

    def pending_customers
        customer_ids = ActiveRecord::Base.connection.execute("select invoices.customer_id from invoices inner join transactions on invoices.id = transactions.invoice_id where transactions.result = 'failed' and invoices.merchant_id = #{self.id} except select invoices.customer_id from transactions inner join invoices on transactions.invoice_id = invoices.id where transactions.result = 'success' and invoices.merchant_id = #{self.id}")
        customer_ids.values.flatten
    end

end
