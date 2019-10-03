class Customer < ApplicationRecord
    validates_presence_of :first_name, :last_name, :id

    has_many :invoices

    def favorite_merchant
        stuff = ActiveRecord::Base.connection.execute("select count(*), invoices.merchant_id from transactions inner join invoices on transactions.invoice_id = invoices.id where invoices.customer_id = #{self.id} and transactions.result = 'success' group by invoices.merchant_id order by count desc limit 1")
        stuff.values.flatten.last
    end
end
