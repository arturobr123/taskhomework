require 'sidekiq/web'

Rails.application.routes.draw do

  #delete archive from homework
  get "homeworks/delete_file_homework" => 'homeworks#delete_file_homework', :as => :delete_file_homework

  #search
  get 'search/search_homeworks'

  #Landing page
  get "landing/faqs" => 'landing#faqs', :as => :faqs
  get "landing/workHere" => 'landing#workHere', :as => :work_here
  get "landing/home" => 'landing#home', :as => :home_page

  #notifications
  resources :notifications, only: [:index,:update]
  get 'notifications/index'
  get "notifications/view_all_notifications" => 'notifications#view_all_notifications', :as => :view_all_notifications

  #notifications
  resources :notificationsworker, only: [:index,:update]
  get 'notificationsworker/index'
  get "notificationsworker/view_all_notifications_worker" => 'notificationsworker#view_all_notifications_worker', :as => :view_all_notifications_worker

  #score homework
  get 'classrooms/score'

  #show modal to score homework
  get 'classrooms/show_to_score' => 'classrooms#show_to_score', :as => :show_to_score

  #controlador para los cobros
  resources :charges

  #controller admin
  resources :trabajadores, as: :admins,only: [:show,:update ,:edit, :index]

  #controller users
  resources :usuarios, as: :users,only: [:show,:update ,:edit, :index]

  #finish homework
  get 'classrooms/finish_homework' => 'classrooms#finish_homework', :as => :finish_homework

  get "homeworks/my_homeworks" => 'homeworks#my_homeworks', :as => :my_homeworks

  #upload files to the classroom
  post 'classrooms/uploadFiles' => 'classrooms#uploadFiles', :as => :uploadFilesClassroom

  resources :classrooms
  resources :proposals
  resources :homeworks
	get "main/home" => 'main#home', :as => :home

  #root 'main#home'

  devise_for :users, path: 'users'
	# eg. http://localhost:3000/users/sign_in
	devise_for :admins, path: 'admins'
	# eg. http://localhost:3000/admins/sign_in


	#si un administrador esta autenticado
  authenticated :admin do
    root 'main#homeAdmin'
  end

  #si un user esta autenticado
  authenticated :user do
  	root 'main#homeUser'
  end

  #si un user  NO esta autenticado
  unauthenticated :user do
    root 'main#userUnregistered'
  end

  #si un administrador NO esta autenticado
  unauthenticated :admin do
    root 'main#adminUnregistered'
  end


  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'

end





