# README

Rails(Rales) engine is an api built to share information gathered from the sales engine data. all API endpoints are returned using JSON.

# Setup && Testing
### To get this repo up and running locally do the following: 
* clone down this repo using ruby 2.4.1
* `bundle`
* `rake db:{create,migrate}`
* `rails import:all` (this may take a minute)
* _Data is located in `./db/data`_

### to run the test suite (spec harness):
* clone down the spec harness from https://github.com/turingschool/rales_engine_spec_harness into the same directory as rails_engine
* cd into `rails_engine_spec_harness`
* `rake`
* smile as the green dots populate the terminal window

### to run the local rspec test suite
* within the rails_engine repo
* `bundle exec rspec` || `rspec` || `rake`
* simplecov is also installed so you can run `open coverage/index.html` to check test coverage

# DB Schema
![db_schema](https://i.ibb.co/dgsf5QQ/Screen-Shot-2019-10-06-at-3-51-22-PM.png)

# Endpionts
## Record Endpoints
* `/api/v1/merchants` returns all merchants
* `/api/v1/customers` returns all customers
* `/api/v1/invoices` returns all invoices
* `/api/v1/items` returns all items
* `/api/v1/invoice_items` returns all invoice_items
* `/api/v1/transactions` returns all transactions
* `/api/v1/merchants/:id` returns the merchant with associated id
* `/api/v1/customers/:id` returns the customer with associated id
* `/api/v1/invoices/:id` returns the invoice with associated id
* `/api/v1/items/:id` returns the item with associated id
* `/api/v1/invoice_items/:id` returns the invoice_item with associated id
* `/api/v1/transactions/:id` returns the transaction with associated id

## Relationship Endpoints
* `/api/v1/merchants/:id/items` returns a collection of items associated with that merchant
* `/api/v1/merchants/:id/invoices` returns a collection of invoices associated with that merchant from their known orders
* `/api/v1/invoices/:id/transactions` returns a collection of associated transactions
* `/api/v1/invoices/:id/invoice_items` returns a collection of associated invoice items
* `/api/v1/invoices/:id/items` returns a collection of associated items
* `/api/v1/invoices/:id/customer` returns the associated customer
* `/api/v1/invoices/:id/merchant` returns the associated merchant
* `/api/v1/invoice_items/:id/invoice` returns the associated invoice
* `/api/v1/invoice_items/:id/item` returns the associated item
* `/api/v1/items/:id/invoice_items` returns a collection of associated invoice items
* `/api/v1/items/:id/merchan`t returns the associated merchant
* `/api/v1/transactions/:id/invoice` returns the associated invoice
* `/api/v1/customers/:id/invoices` returns a collection of associated invoices
* `/api/v1/customers/:id/transactions` returns a collection of associated transactions

## Business Intelligence Endpoints
* `/api/v1/merchants/most_revenue?quantity=x` returns the top x merchants ranked by total revenue
* `/api/v1/merchants/revenue?date=x` returns the total revenue for date x across all merchants
* `/api/v1/merchants/:id/favorite_customer` returns the customer who has conducted the most total number of successful transactions.
* `/api/v1/items/most_revenue?quantity=x` returns the top x items ranked by total revenue generated
* `/api/v1/items/:id/best_day` returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.
* `/api/v1/customers/:id/favorite_merchant` returns a merchant where the customer has conducted the most successful transactions
* `/api/v1/merchants/:id/customers_with_pending_invoices` returns a collection of customers which have pending (unpaid) invoices


## finder endpoints
### Random Finder
* `/api/v1/merchants/random` returns a random merchant
* `/api/v1/customers/random` returns a random customer
* `/api/v1/invoices/random` returns a random invoice
* `/api/v1/items/random` returns a random item
* `/api/v1/invoice_items/random` returns a random invoice_item
* `/api/v1/transactions/random` returns a random transaction

### Single Finder
* `/api/v1/merchants/find?name=x` returns the first merchant with name = x, sorted by id
* `/api/v1/merchants/find?id=x` returns the first merchant with id = x, sorted by id
* `/api/v1/merchants/find?created_at=x` returns the first merchant with created_at = x, sorted by id
* `/api/v1/merchants/find?updated_at=x` returns the first merchant with updated_at = x, sorted by id 
* `/api/v1/customers/find?first_name=x` returns the first customer with first_name = x, sorted by id 
* `/api/v1/customers/find?last_name=x` returns the first customer with last_name = x, sorted by id 
* `/api/v1/customers/find?id=x` returns the first customer with id = x, sorted by id 
* `/api/v1/customers/find?created_at=x` returns the first customer with created_at = x, sorted by id 
* `/api/v1/customers/find?updated_at=x` returns the first customer with updated_at = x, sorted by id
* `/api/v1/items/find?name=x` returns the first item with name = x, sorted by id 
* `/api/v1/items/find?description=x` returns the first item with description = x, sorted by id 
* `/api/v1/items/find?merchant_id=x` returns the first item with merchant_id = x, sorted by id 
* `/api/v1/items/find?id=x` returns the first item with id = x, sorted by id 
* `/api/v1/items/find?unit_price=x` returns the first item with unit_price = x, sorted by id 
* `/api/v1/items/find?created_at=x` returns the first item with created_at = x, sorted by id
* `/api/v1/items/find?upated_at=x` returns the first item with updated_at = x, sorted by id
* `/api/v1/invoices/find?id=x` returns the first invoice with id = x, sorted by id 
* `/api/v1/invoices/find?merchant_id=x` returns the first invoice with merchant_id = x, sorted by id 
* `/api/v1/invoices/find?customer_id=x` returns the first invoice with customer_id = x, sorted by id 
* `/api/v1/invoices/find?status=x` returns the first invoice with status = x, sorted by id
* `/api/v1/invoices/find?created_at=x` returns the first invoice with created_at = x, sorted by id
* `/api/v1/invoices/find?upated_at=x` returns the first invoice with updated_at = x, sorted by id
* `/api/v1/invoice_items/find?id=x` returns the first invoice_item with id = x, sorted by id 
* `/api/v1/invoice_items/find?invoice_id=x` returns the first invoice_item with invoice_id = x, sorted by id 
* `/api/v1/invoice_items/find?quantity=x` returns the first invoice_item with quantity = x, sorted by id 
* `/api/v1/invoice_items/find?unit_price=x` returns the first invoice_item with unit_price = x, sorted by id
* `/api/v1/invoice_items/find?created_at=x` returns the first invoice_item with created_at = x, sorted by id
* `/api/v1/invoice_items/find?upated_at=x` returns the first invoice_item with updated_at = x, sorted by id


### Multi Finder
* `/api/v1/merchants/find_all?name=x` returns all merchants with name = x, sorted by id 
* `/api/v1/merchants/find_all?id=x` returns all merchants with id = x, sorted by id 
* `/api/v1/merchants/find_all?created_at=x` returns all merchant with created_at = x, sorted by id 
* `/api/v1/merchants/find_all?updated_at=x` returns all merchant with updated_at = x, sorted by id 
* `/api/v1/customers/find_all?first_name=x` returns all customers with first_name = x, sorted by id 
* `/api/v1/customers/find_all?last_name=x` returns all customers with last_name = x, sorted by id 
* `/api/v1/customers/find_all?id=x` returns all customers with id = x, sorted by id 
* `/api/v1/customers/find_all?created_at=x` returns all customers with created_at = x, sorted by id 
* `/api/v1/customers/find_all?updated_at=x` returns all customer with updated_at = x, sorted by id
* `/api/v1/items/find_all?name=x` returns the items with name = x, sorted by id 
* `/api/v1/items/find_all?description=x` returns the items with description = x, sorted by id 
* `/api/v1/items/find_all?merchant_id=x` returns the items with merchant_id = x, sorted by id 
* `/api/v1/items/find_all?id=x` returns the items with id = x, sorted by id 
* `/api/v1/items/find_all?unit_price=x` returns the items with unit_price = x, sorted by id 
* `/api/v1/items/find_all?created_at=x` returns the items with created_at = x, sorted by id
* `/api/v1/items/find_all?created_at=x` returns the items with updated_at = x, sorted by id
* `/api/v1/invoices/find_all?id=x` returns the invoices with id = x, sorted by id 
* `/api/v1/invoices/find_all?merchant_id=x` returns the invoices with merchant_id = x, sorted by id 
* `/api/v1/invoices/find_all?customer_id=x` returns the invoices with customer_id = x, sorted by id 
* `/api/v1/invoices/find_all?status=x` returns the invoices with status = x, sorted by id
* `/api/v1/invoices/find_all?created_at=x` returns the invoices with created_at = x, sorted by id
* `/api/v1/invoices/find_all?upated_at=x` returns the invoices with updated_at = x, sorted by id
* `/api/v1/invoice_items/find_all?id=x` returns the invoice_items with id = x, sorted by id 
* `/api/v1/invoice_items/find_all?invoice_id=x` returns the invoice_items with invoice_id = x, sorted by id 
* `/api/v1/invoice_items/find_all?quantity=x` returns the invoice_items with quantity = x, sorted by id 
* `/api/v1/invoice_items/find_all?unit_price=x` returns the invoice_items with unit_price = x, sorted by id
* `/api/v1/invoice_items/find_all?created_at=x` returns the invoice_items with created_at = x, sorted by id
* `/api/v1/invoice_items/find_all?upated_at=x` returns the invoice_items with updated_at = x, sorted by id

