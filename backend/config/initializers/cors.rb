# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        # origins "example.com"
        # localhost:300とsample.comを許可
        # origins 'localhost:3000','https://www.sample.com'
        # frontendドメインを許可
        # origins "localhost:8080"
        origins ['https://app.best-pra.com', 'localhost:8080']

        # フロントへ認証情報を送信できるようにする
        # access-control-allow-credentials: true => cokkieを含む認証情報は自動で送信されない
        resource "*",
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true
    end
end
