Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get '/movie_with_director', to: 'movies#find_same_director', as: 'movies_with_director'
end
