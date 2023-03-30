
# cookieに保存したリフレッシュトークンの有効性を判定する

module UserSessionizeService

    # セッションユーザーが居ればtrue、存在しない場合は401を返すfrom_refresh_token
    def sessionize_user
        session_user.present? || unauthorized_user
    end

    # セッションキー
    def session_key
        UserAuth.session_key
    end

    # セッションcookieを削除する
    def delete_session
        cookies.delete(session_key)
    end

    private

        # cookieのtokenを取得
        def token_from_cookies
            # puts "token_from_cookies => #{cookies[session_key]}"
            cookies[session_key]
        end

        # refresh_tokenから有効なユーザーを取得する
        def fetch_user_from_refresh_token
            User.from_refresh_token(token_from_cookies)
        rescue JWT::InvalidJtiError
            # jtiエラーの場合はcontrollerに処理を委任
            catch_invalid_jti
        rescue UserAuth.not_found_exception_class,
                JWT::DecodeError, JWT::EncodeError
            nil
        end

        # refresh_tokenのユーザーを返す
        def session_user
            return nil unless token_from_cookies
            @_session_user ||= fetch_user_from_refresh_token
        end

        # jtiエラーの処理
        def catch_invalid_jti
            delete_session
            raise JWT::InvalidJtiError
        end

        # 認証エラー
        def unauthorized_user
            delete_session
            head(:unauthorized)
        end
end