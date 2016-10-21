require 'rails_helper'
require 'pry-rails'

describe UsersController do

  describe 'with user login' do
    let(:user){ create(:user) }

    describe 'GET #show' do

      before :each do
        get :show, id: user
      end

      #要求されたuserが@userに格納されていること
      it "assigns the requested to @user" do
        expect(assigns(:user)).to eq user
      end

      #showテンプレートを表示すること
      it "renders the :show template" do
        expect(response).to render_template :show
      end

    end
  end
end
