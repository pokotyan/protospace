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

    describe 'PATCH #update' do

      before :each do
        patch :update, id: @user, user: attributes_for(:user,name: "update_name")
        @user.reload
      end

      #current_userが@userと等しいこと。（ユーザー編集できるのはログインしている自分自身のみ）
      it "assigns the requested to user to @user" do
        expect(assigns(:current_user)).to eq @user
      end

      #更新できること
      it "change @user's attributes" do
        expect(@user.name).to eq "update_name"
      end

      #rootページにリダイレクトすること
      it "redirect to prototype_path" do
        expect(response).to redirect_to root_path
      end

      #更新完了のflashメッセージが出ること
      it "shows flash message to update user successfully" do
        expect(flash[:notice]).to eq 'プロフィールの編集が完了しました'
      end

    end

  end
end
