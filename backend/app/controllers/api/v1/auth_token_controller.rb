class Api::V1::AuthTokenController < ApplicationController
    include UserSessionizeService

    # 404エラーが発生した場合にヘッダーのみを返す
    rescue_from UserAuth.not_found_exception_class, with: :not_found
    # refresh_tokenのInvalidJitErrorが発生した場合はカスタムエラーを返す
    rescue_from JWT::InvalidJtiError, with: :invalid_jti

    # userのログイン情報を確認する
    # before_action :authenticate, only: [:login]
    before_action :authenticate, only: [:login]
    # 処理前にsessionを削除する
    before_action :delete_session, only: [:login]
    # session_userを取得、存在しない場合は401を返す
    # before_action :sessionize_user, only: [:refresh, :destroy]
    before_action :sessionize_user, only: [:refresh, :destroy, :logout, :update_email, :update_password]

    # 新規作成
    def create
        @user = User.new(user_params)
        if @user.save!
            # @user = login_user
            set_refresh_token_to_cookie
            render json: login_response
        else
            render @user.errors.full_messages
        end
    end

    # ログイン
    def login
        @user = login_user
        set_refresh_token_to_cookie
        render json: login_response
    end

    # ゲストログイン
    def guest
        @user = User.guest
        if @user.save!
            set_refresh_token_to_cookie
            render json: login_response
        else
            render @user.errors.full_messages
        end
    end

    # リフレッシュ
    def refresh
        @user = session_user
        # 自動更新しない  => リフレッシュトークンの有効期限で再ログインを強制する場合は下記をコメントアウト
        # 自動更新する => 下記を実装して都度リフレッシュトークンを更新する
        # ゲストユーザーはリフレッシュトークンを更新しない
        if @user && @user.guest_flg == false
            set_refresh_token_to_cookie
        end
        render json: login_response
    end

    def logout
        delete_session if session_user.forget
        cookies[session_key].nil? ?
        head(:ok) : response_500("Could not delete session")
    end

    # メールアドレス更新
    def update_email
        @user = current_user
        if @user.update!(email: params[:user][:email])
            update_email_password
        else
            render 'update_email_password', status: 400
        end
    end

    # パスワード更新
    def update_password
        @user = current_user
        if @user.update!(password: params[:user][:password])
            update_email_password
        else
            render 'update_email_password', status: 400
        end
    end

    # ユーザ削除 && cookieの情報を削除する
    def destroy
        delete_user = User.find(params[:id])
        return if current_user.id != delete_user.id
        if current_user.destroy!
            delete_session if session_user.forget
            cookies[session_key].nil? ?
            head(:ok) : response_500("Could not delete session && destroy")
        else
            render :destroy, status: 400
        end
    end

    private

        # params[:email]からアクティブなユーザーを返す
        def login_user
            @_login_user ||= User.find_by_activated(auth_params[:email])
        end

        # ログインユーザーが居ない、もしくはpasswordが一致しない場合404を返す
        def authenticate
            # unless login_user.present? &&
            #         login_user.authenticate(auth_params[:password])
            #     raise UserAuth.not_found_exception_class
            # end
            if !login_user.present? || !login_user.authenticate(auth_params[:password])
                raise UserAuth.not_found_exception_class
            end
        end

        # refresh_tokenをcookieにセットする
        # 本番環境でのみsecureを有効に => httpsでないと送信できないようにする。
        #  httpな開発環境ではエラーになるので本番環境のみにする
        # http_only = true => javaScriptがアクセスできないようにする
        def set_refresh_token_to_cookie
            cookies[session_key] = {
                value: refresh_token,
                expires: refresh_token_expiration,
                secure: Rails.env.production?,
                http_only: true
            }
        end

        # ログイン時のデフォルトレスポンス
        def login_response
            {
                token: access_token,
                expires: access_token_expiration,
                user: @user.response_json(sub: access_token_subject)
            }
        end

        # リフレッシュトークンのインスタンス生成
        def encode_refresh_token
            @_encode_refresh_token ||= @user.encode_refresh_token
        end

        # リフレッシュトークン
        def refresh_token
            encode_refresh_token.token
        end

        # リフレッシュトークンの有効期限
        def refresh_token_expiration
            Time.at(encode_refresh_token.payload[:exp])
        end

        # アクセストークンのインスタンス生成
        def encode_access_token
            @_encode_access_token ||= @user.encode_access_token
        end

        # アクセストークン
        def access_token
            encode_access_token.token
        end

        # アクセストークンの有効期限
        def access_token_expiration
            encode_access_token.payload[:exp]
        end

        # アクセストークンのsubjectクレーム
        def access_token_subject
            encode_access_token.payload[:sub]
        end

        # 404ヘッダーのみの返却を行う
        # Doc: https://gist.github.com/mlanett/a31c340b132ddefa9cca
        def not_found
            head(:not_found)
        end

        # decode jti != user.refresh_jti のエラー処理
        def invalid_jti
            msg = "Invalid jti for refresh token"
            render status: 401, json: { status: 401, error: msg }
        end

        def auth_params
            params.require(:auth).permit(:email, :password)
        end

        # user情報を取得
        def user_params
            params.require(:user).permit(:nickname, :email, :password, :avatar, :introduction, :birthday , :basecolor_id, :activated, :admin)
        end

        # 一度cookieの情報を削除して、新しい情報に変える
        def update_email_password
            delete_session if session_user.forget
            set_refresh_token_to_cookie
            render json: login_response
            # render status: :ok
        end
end
