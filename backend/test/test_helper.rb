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
    load "#{Rails.root}/db/seeds.rb"
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
    User.find_by(activated: true)
  end
end
