class ApplicationController < ActionController::API

    # cookieを扱うためのモジュール
    include ActionController::Cookies
    # 認証を行う
    include UserAuthenticateService

end
