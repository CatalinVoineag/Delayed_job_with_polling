Rails.application.routes.draw do
  root "products#index"
  get 'progress_products/:job_id' => 'products#progress_job'
  get 'download_products' => 'products#download_csv', as: :download_csv
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
end