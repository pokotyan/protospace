require 'rails_helper'

RSpec.feature 'post_prototype', type: :feature do

  given!(:user) { create(:user) }

  scenario 'post_prototype', js: true do
    binding.pry
    visit root_path
    find('.navbar-btn').click
    fill_in 'E-Mail address', with: user.email
    fill_in 'Password', with: user.password
    click_on "Sign in"

    expect(page).to have_selector '.alert-notice',   text: 'Signed in successfully.'
  end

end
