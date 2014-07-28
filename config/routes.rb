Rails.application.routes.draw do
  # 验证码
  captcha_route
  mount Ckeditor::Engine => '/ckeditor'
  mount ChinaCity::Engine => '/china_city'
  devise_for :admins
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations'}
  devise_scope :user do
    get "users/sign_in_by_telephone" => "users/sessions#new_by_telephone", as: 'new_by_telephone_user_session'
    post "users/sign_in_by_telephone" => "users/sessions#create_by_telephone", as: 'telephone_user_session'
  end

  # 手机动态验证码
  post "phone_authcode"  => "authcode"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'front/welcome#index'

  ## 前台site
  namespace :front, path: '/' do
    get 'catagory/:catagory_id' => 'welcome#list_posts', as: :catagory
    get 'catagory/:catagory_id/post/:post_id' => 'welcome#show_post', as: :post
    # 得到当前是否登录，适用于AJAX请求
    get 'sign_in_status'

    # 车检站
    resources :stations, only: [:index, :show] do
      resources :orders, only: [:new, :create, :show]
    end

    # 提问留言
    namespace :question do
      get 'index_faq'
      get 'index_uaq'
    end

    namespace :user do
      root 'dashboard#index' 
      resources :uaqs
      resources :orders, only: [:index, :show] do
        member do
          patch :cancel
        end
      end
    end

  end

  ## 后台site
  namespace :back, path: 'admin_console' do
    namespace :system do
      root 'dashboard#index' 
      resources :system_admins
      resources :station_admins
      resources :catagories
      resources :faqs
      resources :uaqs, except: [:new, :create, :destroy]
      resources :posts do
        member do
          patch 'complete'
          patch 'publish'
          patch 'reject'
          patch 'lock'
          patch 'unlock'
          get 'preview'
        end
      end
      resources :stations do
        member do
          patch 'review'
          patch 'lock'
          patch 'unlock'
        end
      end
    end

    namespace :mystation do
      root 'dashboard#index' 
      resources :station_admins
      resource :station, only: [:show, :edit, :update] do
        member do
          get :edit_picture
          post :update_picture
        end
      end
      resources :order_phones, except: [:index, :show]
      # resources :order_nets, only: [:show]
      resources :orders, only: [:index, :show] do
        collection do
          get "show_order_no"
        end
        member do
          patch "cancel"
          patch "check"
          patch "missit"
        end
      end
      namespace :station_settings do 
        get "time_area"
        put "update_time_area"
      end
    end

    # 个人中心
    namespace :personal do
      get 'show'
      get 'edit'
      put 'update'
      get 'password'
      patch 'update_password'
    end

  end

  get 'admin_console/*unmatched_route', :to => 'back#raise_not_found!'
  get '*unmatched_route', :to => 'application#raise_not_found!'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
