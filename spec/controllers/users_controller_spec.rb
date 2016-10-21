require 'rails_helper'
require 'pry-rails'

describe UsersController do

  describe 'with user login' do
    login_user

    describe 'GET #show' do

      before :each do
        get :show, id: @user
      end

      #要求されたuserが@userに格納されていること
      it "assigns the requested to @user" do
        expect(assigns(:user)).to eq @user
      end

      #showテンプレートを表示すること
      it "renders the :show template" do
        expect(response).to render_template :show
      end

    end

    describe 'GET #edit' do

      before :each do
        get :edit, id: @user
      end

      #editテンプレートを表示すること
      it "renders the :edit template" do
        expect(response).to render_template :edit
      end

    end

  end
end
