require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
    if Rails.env.production?
        config.storage :fog
        config.fog_provider = 'fog/aws'
        config.fog_directory  = 'bestpra-public-s3-access-bucket'
        config.asset_host = "https://s3-ap-northeast-1.amazonaws.com/bestpra-public-s3-access-bucket"
        config.fog_public = true
        config.fog_credentials = {
            provider: 'AWS',
            aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
            aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
            region: 'ap-northeast-1',
        }
        # キャッシュをS3に保存
        # config.cache_storage = :fog
    else
        # 開発環境はlocalに保存
        config.storage :file
        config.asset_host = 'http://localhost:3000'
        # config.enable_processing = false if Rails.env.test? #test:処理をスキップ
    end
end