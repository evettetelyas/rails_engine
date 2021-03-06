class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'citext'

    create_table :transactions do |t|
      t.references :invoice
      t.string :credit_card_number
      t.string :credit_card_expiration_date, default: nil
      t.citext :result

      t.timestamps
    end
  end
end
