require 'rails_helper'

RSpec.describe Api::V1::AuthTokenController, type: :request do
    # let => 遅延評価
    let(:user) { User.create(nickname: "test auth", email: "auth@example.com", password: "password", activated: true) }
    let(:params) { { auth: { email: user.email, password: "password" } } }
    let(:access_lifetime) { UserAuth.access_token_lifetime }
    let(:refresh_lifetime) { UserAuth.refresh_token_lifetime }
    let(:session_key) { UserAuth.session_key.to_s }
    let(:access_token_key) { "token" }

    describe "POST /auth_token/refresh" do
        context "when the request is invalid" do
            before do
                # post "/api/auth_token/refresh", xhr: true
                post api('/auth_token/refresh'), xhr: true, params: { auth: { email: user.email, password: "password" } }
                # user.reload
            end

            it "returns 401 Unauthorized" do
                expect(response).to have_http_status(:unauthorized)
            end

            it "does not return any response body" do
                expect(response.body).to be_blank
            end

            it "does not save the refresh_jti" do
                user.reload
                expect(user.refresh_jti).to be_nil
            end
        end

        context "when the request is valid" do
            before do
                login(params)
            end

            it "returns 200 OK" do
                expect(response).to have_http_status(:ok)
            end

            it "saves the refresh_jti" do
                user.reload
                expect(user.refresh_jti).not_to be_nil
            end

            it "returns the correct user in the response body" do
                expect(JSON.parse(response.body)["user"]["id"]).to eq(user.id)
            end

            it "returns the correct access token" do
                access_token = User.decode_access_token(JSON.parse(response.body)[access_token_key])
                expect(access_token.entity_for_user).to eq(user)
                expect(access_token.payload["exp"]).to eq(JSON.parse(response.body)["expires"])
            end

            it "returns the correct cookie" do
                cookie = @request.cookie_jar.instance_variable_get(:@set_cookies)[session_key]
                expect(cookie[:expires].to_i).to eq((refresh_lifetime.from_now).to_i)
                expect(cookie[:secure]).to eq(Rails.env.production?)
                expect(cookie[:http_only]).to be_truthy
            end

            it "returns the correct refresh token" do
                user.reload
                refresh_token = User.decode_refresh_token(cookies[session_key])
                expect(refresh_token.entity_for_user).to eq(user)

                expect(refresh_token.payload["jti"]).to eq(user.refresh_jti)
                # 誤差1秒を許容する
                expect(refresh_token.payload["exp"]).to be_within(1.second).of(refresh_lifetime.from_now.to_i)
            end
        end
    end

    describe 'invalid login from create action' do
        context 'when the request is invalid' do
            let(:invalid_params_password) { { auth: { email: user.email, password: "passworda" } } }
            let(:invalid_params_email) { { auth: { email: "11111111@example", password: "password" } } }

            it 'password diff returns 404 Not Found' do
                login(invalid_params_password, false)
                expect(response).to have_http_status(:not_found)
            end

            it 'email diff returns 404 Not Found' do
                login(invalid_params_email, false)
                expect(response).to have_http_status(:not_found)
            end

            it 'not XHR return 403 Forbidden' do
                post api('/auth_token'), xhr: false, params: params
                expect(response).to have_http_status(:forbidden)
            end
        end
    end

    describe "refresh_action" do
        context 'refreshs tokens successfully' do
            it "login action successfully" do
                # 有効なログイン
                login(params)
                expect(response).to have_http_status(:ok)
                user.reload
                old_access_token = res_body[access_token_key]
                old_refresh_token = cookies[session_key]
                old_user_jti = user.refresh_jti

                # nilでないか
                expect(old_access_token).to_not be_nil
                expect(old_refresh_token).to_not be_nil
                expect(old_user_jti).to_not be_nil

                # refreshアクションにアクセス
                token = login(params)
                post api("/auth_token/refresh"), xhr: true, headers: auth(token)
                expect(response.status).to eq(200)
                user.reload
                res_body = JSON.parse(response.body)
                new_access_token = res_body[access_token_key]
                new_refresh_token = cookies[session_key]
                new_user_jti = user.refresh_jti

                # nilでないか
                expect(new_access_token).to_not be_nil
                expect(new_refresh_token).to_not be_nil
                expect(new_user_jti).to_not be_nil

                # tokenとjtiが新しく発行されているか
                expect(old_access_token).to_not eq(new_access_token)
                expect(old_refresh_token).to_not eq(new_refresh_token)
                expect(old_user_jti).to_not eq(new_user_jti)

                # user.refresh_jtiは最新のjtiと一致しているか
                payload = User.decode_refresh_token(new_refresh_token).payload
                expect(payload["jti"]).to eq(new_user_jti)
            end
        end

        context 'refrehs tokens failed' do
            it "returns 401 if refresh_token doesn't exist" do
                post api("/auth_token/refresh"), xhr: true
                expect(response).to have_http_status(:unauthorized)
            end

            it "returns 401 if refresh_token is expired" do
                login(params)
                travel_to(refresh_lifetime.from_now) do
                    # token = login(params)
                    # post api("/auth_token/refresh"), xhr: true, headers: auth(token)
                    logout
                    expect(response).to have_http_status(:unauthorized)
                    expect(response.body).to be_blank
                end
            end

            it "returns 401 and clears cookie if the jti is invalid" do
                token = login(params)
                old_refresh_token = cookies[session_key]

                # log in again to get new refresh token
                login(params)
                new_refresh_token = cookies[session_key]

                # set old refresh_token to cookie
                cookies[session_key] = old_refresh_token
                expect(cookies[session_key]).not_to be_blank

                post api("/auth_token/refresh"), xhr: true, headers: auth(token)
                expect(response).to have_http_status(:unauthorized)

                # check if cookie is cleared
                expect(cookies[session_key]).to be_blank

                # check error message for jti error
                expect(res_body["error"]).to eq("Invalid jti for refresh token")
            end
        end
    end

    describe "DELETE /logout" do
        context "when user is logged in" do
            before do
                login(params)
                user.reload
            end

            it "destroys the session and refresh token" do
                expect(response).to have_http_status(:ok)
                expect(user.refresh_jti).not_to be_nil
                expect(request.cookie_jar[session_key]).not_to be_nil

                # delete destroy_sessions_path
                logout
                expect(response).to have_http_status(:ok)
                expect(cookies[@session_key]).to be_blank
                user.reload
                expect(user.refresh_jti).to be_nil
            end
        end

        context "when session is missing" do
            before do
                cookies[session_key] = nil
            end

            it "returns unauthorized status" do
                # delete destroy_sessions_path
                logout

                expect(response).to have_http_status(:unauthorized)
            end
        end

        context "when session has expired" do
            before do
                login(params)
                travel_to(refresh_lifetime.from_now)
            end

            it "returns unauthorized status" do
                # delete destroy_sessions_path
                logout

                expect(response).to have_http_status(:unauthorized)
                expect(cookies[session_key]).to be_blank
            end
        end
    end
end