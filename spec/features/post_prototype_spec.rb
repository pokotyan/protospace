require 'rails_helper'

RSpec.feature 'Sign_upとLog_out', type: :feature do

  given(:current_user_name) { "foo" }

  scenario 'Sign_upとLog_out', js: true do

    visit new_user_registration_path

    # ログインフォームを埋める
    fill_in 'username', with: current_user_name
    fill_in 'E-Mail', with: 'foo@example.com'
    fill_in 'Password', with: '1234567'

    # サインアップ
    click_on 'save'

    # ログインに成功したことを検証する
    expect(page).to have_selector '.alert-notice',   text: 'Welcome! You have signed up successfully.'

    #ログアウト
    click_on 'foo'
    click_on 'Logout'
    # ログアウトして現在、rootに戻っていること
    expect(current_path).to eq root_path

  end
end
