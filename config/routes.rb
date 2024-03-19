Rails.application.routes.draw do
  get "/common_ancestor", to: "common_ancestor#search"
  post "/birds", to: "birds#search"
end
