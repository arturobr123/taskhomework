require 'sidekiq/web'

Rails.application.routes.draw do

  #PayPal
  get 'classrooms/execute_payment_paypal' => 'classrooms#execute_payment_paypal', :as => :execute_payment_paypal
  get 'classrooms/select_proposal_paypal' => 'classrooms#select_proposal_paypal', :as => :select_proposal_paypal
  get 'classrooms/create_classroom_paypal' => 'classrooms#create_classroom_paypal', :as => :create_classroom_paypal

  #plagiarism_checker
  get 'classrooms/plagiarism_checker' => 'classrooms#plagiarism_checker', :as => :plagiarism_checker

  get "trabajadores/first_phrase" => 'trabajadores#first_phrase', :as => :first_phrase
  get "trabajadores/upload_clabe" => 'trabajadores#upload_clabe', :as => :upload_clabe
  get "trabajadores/phrase" => 'trabajadores#phrase', :as => :phrase
  get "trabajadores/clabe" => 'trabajadores#clabe', :as => :clabeAccount

  resources :chat_rooms, only: [:new, :create, :show, :index]

  #send insatisfaction comment
  get 'classrooms/send_disagree_homework_email' => 'classrooms#send_disagree_homework_email', :as => :send_disagree_homework_email
  #page to send the insatisfaction comment homework
  get 'classrooms/disagree_homework' => 'classrooms#disagree_homework', :as => :disagree_homework
  #user agree with homework
  get 'classrooms/agree_homework' => 'classrooms#agree_homework', :as => :agree_homework

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
