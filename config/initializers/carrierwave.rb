CarrierWave.configure do |config|
  if Rails.env == 'development' || Rails.env == 'production'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
      region: 'us-east-1'
    }
    config.storage = :fog
    config.fog_directory  = 'upload-test-soga'
    config.asset_host = 'https://s3.amazonaws.com/upload-test-soga'
  elsif Rails.env == 'test'
    config.storage :file
  end
end
