Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :survivors do
        resources :inventory
      end
      put 'trade', to: 'inventory#trade'
      patch 'trade', to: 'inventory#trade'
      
      resources :infection_reports

      get 'reports/infecteds'
      get 'reports/non_infecteds'
      get 'reports/average_items'
      get 'reports/points_lost'
    end
  end
end
