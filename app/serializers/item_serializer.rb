class ItemSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :name, :description, :merchant_id, :best_day

    attribute :unit_price do |object|
        "$#{object.unit_price}"
    end

  end