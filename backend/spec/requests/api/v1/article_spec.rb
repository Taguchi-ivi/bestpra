require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :request do

    before(:all) do
        @login_user = User.create(nickname: "test taro", email: "example@example.com", password: "password", activated: true)
        @params = { auth: { email: @login_user.email, password: "password" } }
        @token = login(@params)
        # @level = LevelList.create(name: "level1")
        # @article = Article.create(title: "title1", content: "body1", user_id: @login_user.id, level_list_id: @level.id)
        # @access_lifetime = UserAuth.access_token_lifetime
        # @refresh_lifetime = UserAuth.refresh_token_lifetime
        # @session_key = UserAuth.session_key.to_s
        # @access_token_key = "token"
    end

    describe 'GET articles' do
        # subject(:call_api) { get '/api/v1/articles.json' }
        subject(:call_api) { get api('/articles'), xhr: true, headers: auth(@token) }
        let!(:user) { create(:user) }
        let!(:level) { create(:level_list) }
        let!(:articles) { create_list(:article, 3, user_id: user.id, level_list_id: level.id) }

        context '成功' do
            it '200ステータスが返ってくることを確認' do
                call_api
                expect(response.status).to eq 200
            end

            it '作成した記事が返ってくることを確認' do
                call_api
                expect(res_body.length).to eq 3
            end

            it '記事のタイトルが返ってくることを確認' do
                call_api
                expect(res_body[0]["title"]).to eq articles[0].title
            end
        end

        context '失敗' do
            it 'header情報がないと403が返ってくることを確認' do
                get api('/articles')
                expect(response.status).to eq 403
            end
        end
    end

    describe 'GET articles/:id' do
        subject(:call_api) { get api("/articles/#{article.id}"), xhr: true, headers: auth(@token)}
        let!(:level) { create(:level_list) }
        let!(:article) { create(:article, level_list_id: level.id) }

        context '成功' do
            it '200ステータスが返ってくることを確認' do
                call_api
                expect(response.status).to eq 200
            end

            it '記事のタイトルが返ってくることを確認' do
                call_api
                expect(res_body["title"]).to eq article.title
            end
        end

        context '失敗' do
            it 'header情報がないと403が返ってくることを確認' do
                get api("/articles/#{article.id}")
                expect(response.status).to eq 403
            end
        end
    end

    describe 'current_liked' do
        subject(:call_api) { get api("/articles/current_liked"), xhr: true, headers: auth(@check_token)}

        context '成功' do
            it '200ステータスが返ってくることを確認' do
                @check_token = login(@params)
                call_api
                expect(response.status).to eq 200
            end

            it 'いいねしたIDが返ってくることを確認' do
                user = create(:user)
                article = create(:article)
                like = create(:like, user_id: user.id, article_id: article.id)
                @check_token = login({ auth: { email: user.email, password: "password" } })
                call_api
                expect(res_body['currentLiked']).to include article.id
            end

            it 'いいねした記事が返ってくることを確認' do
                user = create(:user)
                article = create(:article)
                like = create(:like, user_id: user.id, article_id: article.id)
                @check_token = login({ auth: { email: user.email, password: "password" } })
                call_api
                expect(res_body['likes'][0]['id']).to eq article.id
                expect(res_body['likes'][0]['title']).to eq article.title
                expect(res_body['likes'][0]['content']).to eq article.content
            end
        end

        context '失敗' do
            it 'header情報がないと403が返ってくることを確認' do
                get api("/articles/current_liked")
                expect(response.status).to eq 403
            end

            it 'いいねしていないユーザーはIDが返ってこないこと' do
                other_user = User.create(nickname: "test jiro", email: "example22@example.com", password: "password", activated: true)
                @check_token = login({ auth: { email: other_user.email, password: "password" } })
                call_api
                expect(res_body['currentLiked']).to eq []
            end

            it 'いいねしていないユーザーは記事が返ってこないこと' do
                other_user = User.create(nickname: "test jiro", email: "example22@example.com", password: "password", activated: true)
                @check_token = login({ auth: { email: other_user.email, password: "password" } })
                call_api
                expect(res_body['likes']).to eq []
            end
        end
    end

    describe 'GET article_about' do
        subject(:call_api) { get api("/articles/article_about"), xhr: true}
        let!(:user) { create(:user) }
        let!(:level) { create(:level_list) }
        let!(:articles) { create_list(:article, 4, user_id: user.id, level_list_id: level.id) }

        context '成功' do
            it '200ステータスが返ってくることを確認' do
                call_api
                expect(response.status).to eq 200
            end

            it '記事のタイトルが返ってくることを確認' do
                call_api
                expect(res_body[0]["title"]).to eq articles[0].title
            end

            it '記事が3件だけ返ってくることを確認' do
                call_api
                expect(res_body.length).to eq 3
            end
        end
    end

    describe 'GET search' do
        subject(:call_api) { get api("/articles/search"), xhr: true, headers: auth(@token), params: { keyword: @keyword } }
        let!(:article) { create(:article, title: 'aaa', content: 'bbb')}

        context '成功' do
            it '200ステータスが返ってくることを確認' do
                @keyword = ''
                call_api
                expect(response.status).to eq 200
            end

            it 'キーワード(title)の記事が返ってくることを確認' do
                @keyword = 'a'
                call_api
                expect(res_body[0]["title"]).to eq article.title
            end

            it 'キーワードの記事(content)が返ってくることを確認' do
                @keyword = 'b'
                call_api
                expect(res_body[0]["content"]).to eq article.content
            end
        end

        context '失敗' do
            it 'header情報がないと403が返ってくることを確認' do
                get api("/articles/search"), params: { keyword: @keyword }
                expect(response.status).to eq 403
            end

            it 'キーワードの記事が存在しないと空の配列が返ってくることを確認' do
                @keyword = 'c'
                call_api
                expect(res_body).to eq []
            end
        end
    end

    describe 'PATCH update' do
        subject(:call_api) { patch api("/articles/#{@article_id}"), xhr: true, headers: auth(@check_token),
                            params: { article: { title: 'new title', content: 'new content', tag_list: [] } } }
        # let!(:user) { create(:user) }
        # let!(:article) { create(:article, user: user, title: 'aaa', content: 'bbb')}

        context '成功' do
            it '変更されることを確認' do
                user = create(:user)
                article = create(:article, user: user)
                @article_id = article.id
                @check_token = login({ auth: { email: user.email, password: "password" } })
                call_api
                expect(res_body['title']).to eq 'new title'
                expect(res_body['content']).to eq 'new content'
            end
        end

        context '失敗' do
            it 'header情報がないと403が返ってくることを確認' do
                article = create(:article)
                patch api("/articles/#{article.id}"), params: { article: { title: 'new title', content: 'new content' } }
                expect(response.status).to eq 403
            end

            it '存在しない記事は変更できないことを確認' do
                @article_id = 'aa'
                user = create(:user)
                @check_token = login({ auth: { email: user.email, password: "password" } })
                call_api
                expect(res_body).to eq 'bad_request'
            end

            it '作成したユーザーではないと変更できないことを確認' do
                user = User.create(nickname: "test siro", email: "example44@example.com", password: "password", activated: true)
                article = create(:article, user: user)
                @article_id = article.id
                other_user = User.create(nickname: "test sabro", email: "example33@example.com", password: "password", activated: true)
                @check_token = login({ auth: { email: other_user.email, password: "password" } })
                call_api
                expect(res_body).to eq 'bad_request'
            end
        end
    end


end