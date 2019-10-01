class InvoiceItemSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :invoice_id, :item_id, :quantity

    attribute :unit_price do |object|
      "$#{object.unit_price}"
    end
    
  end