Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      get 'merchants/revenue', to: 'merchants/revenues#show'
      get 'merchants/most_revenue', to: 'merchants/most_revenues#index'
      resources :merchants, only: [:index, :show] do
        resources :items, module: 'merchants', only: [:index]
        resources :invoices, module: 'merchants', only: [:index]
        get '/favorite_customer', to: 'merchants/favorite_customers#show'
        get '/customers_with_pending_invoices', to: 'merchants/pending_customers#index'
      end
      
      get '/items/most_revenue', to: 'items/most_revenues#index'
      resources :items, only: [:index, :show] do
        resources :invoice_items, module: 'items', only: [:index]
        get '/merchant', to: 'items/merchants#show'
        get '/best_day', to: 'items/best_days#show'
      end

      resources :customers, only: [:index, :show] do
        resources :invoices, module: 'customers', only: [:index]
        resources :transactions, module: 'customers', only: [:index]
        get '/favorite_merchant', to: 'customers/favorite_merchants#show'
      end

      resources :invoices, only: [:index, :show] do
        resources :transactions, module: 'invoices', only: [:index]
        resources :invoice_items, module: 'invoices', only: [:index]
        resources :items, module: 'invoices', only: [:index]
        get '/customer', to: 'invoices/customers#show'
        get '/merchant', to: 'invoices/merchants#show'
      end

      resources :transactions, only: [:index, :show] do
        get '/invoice', to: 'transactions/invoices#show'
      end

      resources :invoice_items, only: [] do
        get '/invoice', to: 'invoice_items/invoices#show'
        get '/item', to: 'invoice_items/items#show'
      end
    end
  end
end
