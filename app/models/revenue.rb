class Revenue
    attr_reader :total_revenue, :id

    def initialize(revenue)
        @total_revenue = revenue
        @id = rand(0...9999999)
    end

end