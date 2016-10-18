require 'rails_helper'
require 'pry-rails'

describe PrototypesController do

  describe 'with user login' do
    describe 'GET #index' do

      before :each do
        get :index
      end

      #作成されたprototypeたちが@prototypesに格納されていること
      it "assigns the requested prototypes to @prototypes" do
        prototype1 = create(:prototype_with_main_image, title: "test1")
        prototype2 = create(:prototype_with_main_image, title: "test2")
        expect(assigns(:prototypes).map{|prototype| prototype["title"] }.flatten).to match_array(["test1","test2"])
      end

      #GET #indexでindexテンプレートを表示すること
      it "renders the :index template" do
        expect(response).to render_template :index
      end

    end
    describe 'GET #new' do

      before :each do
        get :new
      end

      #newアクションの@prototypeは未保存の新規レコードであること
      it "assignes the requested prototype to @prototype" do
        expect(assigns(:prototype)).to be_a_new(Prototype)
      end

      #newテンプレートを表示すること
      it "renders the :new template" do
        expect(response).to render_template :new
      end

    end

    describe 'POST #create' do
      login_user
      context "with valid attributes" do

        it "saves the new prototype in the database" do
          binding.pry
          expect{
            post :create, prototype: attributes_for(:prototype_with_main_image, images_attributes: attributes_for(:main_image))
          }.to change{Prototype.count}.by(1)
        end

        it "redirects to root_path" do
        end

        it "shows flash messages to show save the prototype successfully" do
        end

      end
      context "with invalid attributes" do
        it "" do
        end
        it "" do
        end
        it "" do
        end
      end
    end
    describe 'GET #show' do

      let(:prototype){ create(:prototype_with_main_image) }

      before :each do
        get :show, id: prototype
      end

      #要求されたprototypeが@prototypeに格納されていること
      it "assigns the requested prototype to @prototype" do
        expect(assigns(:prototype)).to eq prototype
      end

      #showアクションの@commentは未保存の新規レコードであること
      it "assigns the requested comment to @comment" do
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      #prototype.likesが@prototype.likesと等しいこと（アソシエーションが正しいこと）
      it "assigns likes associated with prototype to @likes" do
        prototype_with_like = create(:prototype_with_main_image, :with_likes)
        like = prototype_with_like.likes.find_by(prototype_id:prototype.id)
        expect(assigns(:prototype).likes.find_by(prototype_id:prototype.id)).to eq like
      end

      #GET #showでshowテンプレートを表示すること
      it "renders the :show template" do
        expect(response).to render_template :show
      end

    end
  end
end
