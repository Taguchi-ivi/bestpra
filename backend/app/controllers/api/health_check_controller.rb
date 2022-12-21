class Api::HealthCheckController < ApplicationController
    def index
        render json: { status: 200 }, status: 200
    end
end