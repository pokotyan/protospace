require 'rails_helper'

RSpec.feature 'post_prototype', type: :feature do

  given!(:user) { create(:user) }

  scenario 'post_prototype', js: true do
    visit root_path
    find('.navbar-btn').click
    fill_in 'E-Mail address', with: user.email
    fill_in 'Password', with: user.password
    click_on "Sign in"

    expect(page).to have_selector '.alert-notice',   text: 'Signed in successfully.'

    #投稿画面へ移動
    find('.navbar-btn').click

    #必須フォームを埋める
    fill_in 'Title', with: 'Title'
    fill_in 'Catch Copy', with: 'Catch Copy'
    fill_in 'Concept', with: 'Concept'

    #第一引数は、name属性、id属性、ラベルのいずれか。第二引数は、ファイルのパスを指定。visible: falseつけないとCapybara::ElementNotFoundが出る
    #http://stackoverflow.com/questions/25278724/capybaraelementnotfound-unable-to-find-file-field-file
    attach_file "prototype_images_attributes_0_image", "#{Rails.root}/spec/fixtures/img/sample.jpg", visible: false

    #prototypeの投稿
    click_on "Publish"
    expect(page).to have_selector '.alert-notice',   text: 'プロトタイプの投稿が完了しました'
  end

end
