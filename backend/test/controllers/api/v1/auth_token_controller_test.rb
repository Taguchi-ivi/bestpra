# テスト成功要件
# cookies[]の操作にはapplication.rbにCookieを処理するmeddlewareを追加
# config.middleware.use ActionDispatch::Cookies
require "test_helper"

class Api::V1::AuthTokenControllerTest < ActionDispatch::IntegrationTest
    def setup
        # @user = active_user
        @user = User.create(nickname: "test taro", email: "example@example.com", password: "password", activated: true)
        @params = { auth: { email: @user.email, password: "password" } }
        @access_lifetime = UserAuth.access_token_lifetime
        @refresh_lifetime = UserAuth.refresh_token_lifetime
        @session_key = UserAuth.session_key.to_s
        @access_token_key = "token"
    end

    # tokenのリフレッシュを行うapi
    def refresh_api
        post api("/auth_token/refresh"), xhr: true
    end

    # 無効なリクエストで返ってくるレスポンスチェック
    def response_check_of_invalid_request(status, error_msg = nil)
        assert_response status
        @user.reload
        assert_nil @user.refresh_jti
        assert_not response.body.present? if error_msg.nil?
        assert_equal error_msg, res_body["error"] if !error_msg.nil?
    end

    # 有効なログイン
    test "valid_login_from_create_action" do
        login(@params)
        assert_response 200
        access_lifetime_to_i = @access_lifetime.from_now.to_i
        refresh_lifetime_to_i = @refresh_lifetime.from_now.to_i

        # jtiは保存されているか
        @user.reload
        assert_not_nil @user.refresh_jti

        # レスポンスユーザーは正しいか
        assert_equal @user.id, res_body["user"]["id"]

        # レスポンス有効期限は想定通りか(1誤差許容)
        assert_in_delta access_lifetime_to_i,
                        res_body["expires"],
                        1

        ## access_token
        access_token = User.decode_access_token(res_body[@access_token_key])

        # ユーザーはログイン本人と一致しているか
        assert_equal @user, access_token.entity_for_user

        # 有効期限はレスポンスと一致しているか
        token_exp = access_token.payload["exp"]
        assert_equal res_body["expires"], token_exp

        ## cookie
        # cookieのオプションを取得する場合は下記を使用
        # @request.cookie_jar.instance_variable_get(:@set_cookies)[<key>]
        cookie = @request.cookie_jar.
                instance_variable_get(:@set_cookies)[@session_key]

        # expiresは想定通りか(1秒許容)
        assert_in_delta Time.at(refresh_lifetime_to_i),
                        cookie[:expires],
                        1.seconds

        # secureは一致しているか
        assert_equal Rails.env.production?, cookie[:secure]

        # http_onlyはtrueか
        assert cookie[:http_only]

        ## refresh_token
        token_from_cookies = cookies[@session_key]
        refresh_token = User.decode_refresh_token(token_from_cookies)
        @user.reload

        # ログイン本人と一致しているか
        assert_equal @user, refresh_token.entity_for_user

        # jtiは一致しているか
        assert_equal @user.refresh_jti, refresh_token.payload["jti"]

        # token有効期限とcookie有効期限は一致しているか
        assert_equal refresh_lifetime_to_i, refresh_token.payload["exp"]
    end

    # 無効なログイン
    test "invalid_login_from_create_action" do
        # 不正なユーザーの場合
        pass = "password"
        invalid_params = { auth: { email: @user.email, password: pass + "a" } }
        login(invalid_params)
        response_check_of_invalid_request 404

        # 下記はメールでログイン認証を実行する場合必要となるテスト
        # アクティブユーザーでない場合
        # inactive_user = User.create(nickname: "a", email: "a@a.a", password: pass)
        # invalid_params = { auth: { email: inactive_user.email, password: pass } }
        # assert_not inactive_user.activated
        # login(invalid_params)
        # response_check_of_invalid_request 404

        # Ajax通信ではない場合
        post api("/auth_token"), xhr: false, params: @params
        response_check_of_invalid_request 403, "Forbidden"
    end

    # 有効なリフレッシュ
    test "valid_refresh_from_refresh_action" do
        # 有効なログイン
        login(@params)
        assert_response 200
        @user.reload
        old_access_token = res_body[@access_token_key]
        old_refresh_token = cookies[@session_key]
        old_user_jti = @user.refresh_jti

        # nilでないか
        assert_not_nil old_access_token
        assert_not_nil old_refresh_token
        assert_not_nil old_user_jti

        # refreshアクションにアクセス
        refresh_api
        assert_response 200
        @user.reload
        new_access_token = res_body[@access_token_key]
        new_refresh_token = cookies[@session_key]
        new_user_jti = @user.refresh_jti

        # nilでないか
        assert_not_nil new_access_token
        assert_not_nil new_refresh_token
        assert_not_nil new_user_jti

        # tokenとjtiが新しく発行されているか #TODO sessionのjtiは新しく発行されているかを確認する
        assert_not_equal old_access_token, new_access_token
        assert_not_equal old_refresh_token, new_refresh_token
        assert_not_equal old_user_jti, new_user_jti

        # user.refresh_jtiは最新のjtiと一致しているか
        payload = User.decode_refresh_token(new_refresh_token).payload
        assert_equal payload["jti"], new_user_jti
    end

    # 無効なリフレッシュ
    test "invalid_refresh_from_refresh_action" do
        # refresh_tokenが存在しない場合はアクセスできないか
        refresh_api
        response_check_of_invalid_request 401

        ## ユーザーが2回のログインを行なった場合
        # 1つ目のブラウザでログイン
        login(@params)
        assert_response 200
        old_refresh_token = cookies[@session_key]

        # 2つ目のブラウザでログイン
        login(@params)
        assert_response 200
        new_refresh_token = cookies[@session_key]

        # 3つ目のブラウザでログイン
        # login(@params)
        # assert_response 200
        # therd_refresh_token = cookies[@session_key]

        # cookieに古いrefresh_tokenをセット
        cookies[@session_key] = old_refresh_token
        assert_not cookies[@session_key].blank?

        # 1つ目のブラウザ(古いrefresh_token)でアクセスするとエラーを吐いているか
        refresh_api
        assert_response 401

        # cookieは削除されているか
        assert cookies[@session_key].blank?

        # jtiエラーはカスタムメッセージを吐いているか
        assert_equal "Invalid jti for refresh token", res_body["error"]

        # 有効期限後はアクセスできないか
        travel_to (@refresh_lifetime.from_now) do
        refresh_api
        assert_response 401
        assert_not response.body.present?
        end
    end

    # ログアウト
    test "destroy_action" do
        # 有効なログイン
        login(@params)
        assert_response 200
        @user.reload
        assert_not_nil @user.refresh_jti
        assert_not_nil @request.cookie_jar[@session_key]

        # 有効なログアウト
        assert_not cookies[@session_key].blank?
        logout
        assert_response 200

        # cookieは削除されているか
        assert cookies[@session_key].blank?

        # userのjtiは削除できているか
        @user.reload
        assert_nil @user.refresh_jti

        # sessionがない状態でログアウトしたらエラーは返ってくるか
        cookies[@session_key] = nil
        logout
        response_check_of_invalid_request 401

        # 有効なログイン
        login(@params)
        assert_response 200
        assert_not cookies[@session_key].blank?

        # session有効期限後にログアウトしたらエラーは返ってくるか
        travel_to (@refresh_lifetime.from_now) do
        logout
        assert_response 401
        # cookieは削除されているか
        assert cookies[@session_key].blank?
        end
    end
end
