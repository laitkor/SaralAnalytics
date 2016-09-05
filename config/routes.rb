Saralanalytics::Application.routes.draw do

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "companies#new", :as => "sign_up"
  get "segmentations/filter"
  get "segmentations/city"
  get "segmentations/country"
  get "segmentations/operating_system"
  get "projects/new"
  get "sessions/new"
  root :to => "admin#dashboard"

  resources :users

  resources :sessions

  resources :password_resets

  resources :companies

  resources :employees

  resources :employees_projects

  resources :projects do
    collection do
      get :learn
      get :startup
      get :quick_setup
      post :get_key
    end
  end

  resources :funnels

  resources :browser_history do
    collection do
      post :histories
    end
  end

  resources :page_title do
    collection do
      post :page_details
    end
  end

  resources :browser_detail do
    collection do
      post :details
    end
  end

  resources :admin do
    collection do
      get :dashboard
      get :explore
      get :audience_overview
      get :comparison_overview
      get :show_browsers
      get :show_operating_systems
      get :demographic
      get :desktop
      get :mobile
    end
  end
end
