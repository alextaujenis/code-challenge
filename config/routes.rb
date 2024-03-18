Rails.application.routes.draw do
  get "/healthcheck", to: proc { [200, {}, [""]] }

  get "/common_ancestor", to: "common_ancestor#index"
end
