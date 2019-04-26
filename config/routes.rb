Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :survivors do
        resources :inventory
      end
      put 'trade', to: 'inventory#trade'
      patch 'trade', to: 'inventory#trade'
      
      resources :infection_reports
    end
  end
end
