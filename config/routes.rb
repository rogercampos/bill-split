Rails.application.routes.draw do
  root "bills#show"

  resource :bills, only: [:show, :create] do
    post :add_person
    post :remove_person
    post :discard
  end

  get "results/:id", to: "bills#shared", as: :shared_bill
end
