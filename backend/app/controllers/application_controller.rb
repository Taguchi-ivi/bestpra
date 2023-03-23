class ApplicationController < ActionController::API

    # cookieを扱うためのモジュール
    include ActionController::Cookies
    # 認証を行う
    include UserAuthenticateService

    # CSRF対策
    # TODO 検証環境ではコメントアウトするとデータの取得可能 ※最後必ずコメントアウトを外す
    # ヘルスチェック時はスキップ
    # before_action :xhr_request?
    before_action :xhr_request?, if: :check_xhr_request?

    private

        # XMLHttpRequestでない場合は403エラーを返す
        def xhr_request?
            # リクエストヘッダ X-Requested-With: 'XMLHttpRequest' の存在を判定
            return if request.xhr?
            render status: :forbidden, json: { status: 403, error: "Forbidden" }
        end

        # Internal Server Error
        def response_500(msg = "Internal Server Error")
            render status: 500, json: { status: 500, error: msg }
        end

        def check_xhr_request?
            true
        end

end