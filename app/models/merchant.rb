class Merchant < ApplicationRecord
    has_many :items
    has_many :invoices

    validates_presence_of :name

    def favorite_customer
        sql = "select count(*), invoices.customer_id from transactions " +
        "inner join invoices on transactions.invoice_id = invoices.id " +
        "where invoices.merchant_id = #{self.id} and transactions.result = 'success' " +
        "group by invoices.customer_id order by count desc limit 1"
        stuff = ActiveRecord::Base.connection.execute(sql)
        stuff.values.flatten.last
    end

    def pending_customers
        data_1 = ActiveRecord::Base.connection.execute("select invoices.customer_id from invoices inner join transactions on invoices.id = transactions.invoice_id where transactions.result = 'failed' and invoices.merchant_id = #{self.id} except select invoices.customer_id from transactions inner join invoices on transactions.invoice_id = invoices.id where transactions.result = 'success' and invoices.merchant_id = #{self.id}")

        data = ActiveRecord::Base.connection.execute("select invoices.id from invoices left join transactions on invoices.id = transactions.invoice_id where invoices.merchant_id = #{self.id} except select invoices.id from invoices inner join transactions on invoices.id = transactions.invoice_id where invoices.merchant_id = #{self.id}")
        customer_ids = data_1.values.flatten
        no_transactions_invoice_ids = data.values.flatten
                
        if no_transactions_invoice_ids.empty?
            customer_ids
        else
            no_payment_customer_ids = Customer.find_by(id: Invoice.find_by(id: no_transactions_invoice_ids).customer_id).id
            customer_ids.push(no_payment_customer_ids)
        end
    end

    def self.most_revenue(number)
        Invoice.joins(:transactions)
        .joins(:invoice_items)
        .where("transactions.result = 'success'")
        .select(:merchant_id)
        .group(:merchant_id)
        .order("sum(quantity * unit_price) desc")
        .limit(number)
        .pluck(:merchant_id)
    end

    def self.date_revenue(date)
        Invoice.joins(:transactions)
        .joins(:invoice_items)
        .where("transactions.result = 'success' and date(invoices.created_at) = '#{date}'")
        .select("date(invoices.created_at), sum(quantity * unit_price)")
        .group("date(invoices.created_at)")
        .order("sum(quantity * unit_price) desc")
        .limit(1)
        .pluck("sum(quantity * unit_price)")
    end
end
