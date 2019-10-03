class Customer < ApplicationRecord
    validates_presence_of :first_name, :last_name

    has_many :invoices

    # def favorite_merchant
    #     stuff = ActiveRecord::Base.connection.execute("select count(*), invoices.merchant_id from transactions inner join invoices on transactions.invoice_id = invoices.id where invoices.customer_id = #{self.id} and transactions.result = 'success' group by invoices.merchant_id order by count desc limit 1")
    #     stuff.values.flatten.last
    # end

    def favorite_merchant
        invoices.joins(:transactions)
        .where("transactions.result = 'success'")
        .select("count(*), invoices.merchant_id")
        .group(:merchant_id)
        .order("count(*) desc")
        .limit(1)
        .pluck(:merchant_id).first
    end
end
