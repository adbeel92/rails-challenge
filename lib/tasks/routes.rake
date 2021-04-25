namespace :api do
  desc 'API Routes'
  task routes: :environment do
    Api::V1::Root.routes.each do |api|
      puts " #{api.request_method} #{api.path}"
    end
  end
end
