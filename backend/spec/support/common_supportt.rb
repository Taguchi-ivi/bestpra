module CommonSupport
    # api path
    def api(path = "/")
        "/api/v1#{path}"
    end

    # 認可ヘッダ
    def auth(token)
        { Authorization: "Bearer #{token}" }
    end

    # 引数のparamsでログインを行う
    def login(params, returnFlg = true)
        # post api("/auth_token"), xhr: true, params: params
        post api("/auth_token/login"), xhr: true, params: params
        # request.headers['Authorization'] = "Bearer #{res_body['token']}"
        return res_body['token'] if returnFlg
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

    RSpec.configure do |config|
        config.include CommonSupport, type: :request
    end
end