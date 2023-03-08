ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# gem minitest-reporters setup
require "minitest/reporters"
Minitest::Reporters.use!


class ActiveSupport::TestCase

  # 並列テスト
  # プロセスが分岐した直後に呼び出し
  parallelize_setup do |worker|
    # seedデータの読み込み
    load "#{Rails.root}/app/db/seeds.rb"
  end



  # 並行テストの有効化/無効化
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # 使わないためコメントアウト fix
  # fixtures :all

  # Add more helper methods to be used by all tests here...

  # アクティブなユーザを返す
  def active_user
    # User.find_by(id: 1)
    User.find_by(activated: true)
  end

  # api path
  def api(path = "/")
    "/api/v1#{path}"
  end

  # 認可ヘッダ
  def auth(token)
    { Authorization: "Bearer #{token}" }
  end

  # 引数のparamsでログインを行う
  def login(params)
    # post api("/auth_token"), xhr: true, params: params
    post api("/auth_token/login"), xhr: true, params: params
  end

  # ログアウトapi
  def logout
    # delete api("/auth_token"), xhr: true
    delete api("/auth_token/logout"), xhr: true
  end

  # レスポンスJSONをハッシュで返す
  def res_body
    JSON.parse(@response.body)
  end
end
