ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/poltergeist'
require 'devise'
require 'support/controller_macros'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryGirl::Syntax::Methods
  Capybara.javascript_driver = :selenium

  # Chromeでテストを動的に確認する
  Capybara.register_driver :selenium do |app|
    # http://code.google.com/p/chromedriver/downloads/list
    # 上記にあるドライバーをlocalのパスが通ってるところに置く
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  #Devise::MissingWardenへの対処 http://ohs30359.hatenablog.com/entry/2016/07/23/094933
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  #deviseのログイン用モジュール
  config.include Devise::TestHelpers, type: :controller #Deviseのテスト用ヘルパー（sign_in user とか）をRspecで使えるようにする
  config.extend ControllerMacros, type: :controller     #作ったControllerMacrosを読み込む

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
