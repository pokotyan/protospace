CarrierWave.configure do |config|
    config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
    region: 'us-east-1'
  }

    if Rails.env == 'development' || Rails.env == 'production'
        config.fog_directory  = 'upload-test-soga'
        config.asset_host = 'https://s3.amazonaws.com/upload-test-soga'
    end
end
