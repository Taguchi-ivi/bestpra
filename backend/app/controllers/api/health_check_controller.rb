class Api::HealthCheckController < ApplicationController
    def index
        # render json: { status: 200 }, status: 200
        head 200
    end

    private
        # albのヘルスチェックの為xhr_requestチェックをスキップ
        def check_xhr_request?
            false
        end
end