Rails.application.routes.draw do
  get "/common_ancestor", to: "common_ancestor#search"
end
