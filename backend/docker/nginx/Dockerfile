# FROM nginx:latest
FROM nginx:stable-alpine

ENV TZ Asia/Tokyo

# デフォルトで用意されている個別設定ファイルを削除
RUN rm -f /etc/nginx/conf.d/*

# ADD nginx.conf /etc/nginx/conf.d/portfolio01-app.conf
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

# ビルド完了後にnginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
