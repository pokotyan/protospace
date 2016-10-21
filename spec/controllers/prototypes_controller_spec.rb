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
      #deviseのログイン(login_user)を事前にしておかないと、コントローラのcurrent_user.prototypes〜の部分で
      #undefined method `prototypes' for nil:NilClass になる。before_action :authenticate_user!を設定してなくてもnilになる。
      login_user
      context "with valid attributes" do
        #prototypeの投稿に必要な属性が全て含まれたparamsを作る。paramsのネストっぷりも実際の投稿を止めて確認し、同じものを再現する。
        let(:post_prototype){post :create,
          prototype: attributes_for(:prototype_with_main_image,
          user_id: @user.id,
          images_attributes: { "0": attributes_for(:main_image) }
          ) }

        #prototypeがデータベースに保存されること
        it "saves the new prototype in the database" do
          expect{post_prototype}.to change{Prototype.count}.by(1)
        end

        #保存後、ルートパスにリダイレクトすること
        it "redirects to root_path" do
          post_prototype
          expect(response).to redirect_to root_path
        end

        #投稿完了のflashメッセージが出ること
        it "shows flash messages to show save the prototype successfully" do
          post_prototype
          expect(flash[:notice]).to eq "プロトタイプの投稿が完了しました"
        end

      end
      context "with invalid attributes" do
        #titleがnilの無効なparams
        let(:post_invalid_prototype){post :create,
          prototype: attributes_for(:prototype_with_main_image,
            title: nil,
            user_id: @user.id,
            images_attributes: { "0": attributes_for(:main_image) }
            ) }

        #無効な属性の場合はデータベースに保存されないこと
        it "does not save the new prototype in the database" do
          expect{post_invalid_prototype}.not_to change{Prototype.count}
        end
        #無効な属性の場合はnewページに戻ること
        it "redirects new_prototype_path" do
          post_invalid_prototype
          expect(response).to render_template :new
        end
        #投稿失敗のflashメッセージが出ること
        it "show flash messages to show save the prototype unsuccessfully" do
          post_invalid_prototype
          expect(flash.now[:alert]).to eq "プロトタイプの投稿に失敗しました"
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
    describe 'GET #edit' do

      login_user
      let(:prototype){ create(:prototype, :with_full_images) }

      before :each do
        get :edit, id: prototype
      end

      #要求されたprototypeが@prototypeに格納されていること
      it "assigns the requested prototype to @prototype" do
        expect(assigns(:prototype)).to eq prototype
      end

      #@prototypeにひもづくmain_imageが@main_imageに格納されていること
      it "assigns main_image to @main_image" do
        expect(assigns(:main_image)).to eq prototype.images.main
      end

      #@prototypeにひもづくsub_imageが@sub_imageに格納されていること
      it "assigns sub_images to @sub_images" do
        expect(assigns(:sub_images)).to eq prototype.images.sub
      end

      #editテンプレートを表示すること
      it "redirect the :edit templlate" do
        expect(response).to render_template :edit
      end

    end
    describe 'PATCH #update' do
      describe 'with valid attributes' do

        let(:prototype){ create(:prototype_with_main_image) }

        before :each do
          patch :update, id: prototype, prototype: attributes_for(:prototype,title: "update")
          prototype.reload
        end

        #要求されたprototypeが@prototypeに格納されていること
        it "assigns the requested prototype to @prototype" do
          expect(assigns(:prototype)).to eq prototype
        end

        #更新できること
        it "updates attributes of prototype" do
          expect(prototype.title).to eq "update"
        end

        #更新したprototypeのページにリダイレクトすること
        it "redirect to prototype_path" do
          expect(response).to redirect_to prototype_path(prototype)
        end

        #更新完了のflashメッセージが出ること
        it "shows flash message to show update prototype successfully" do
          expect(flash[:notice]).to eq "プロトタイプの更新が完了しました"
        end

      end
      describe 'with invalid attributes' do

        let(:prototype){ create(:prototype_with_main_image) }

        before :each do
          patch :update, id: prototype, prototype: attributes_for(:prototype,title: nil)
          prototype.reload
        end

        #要求されたprototypeが@prototypeに格納されていること
        it "assigns the requested prototype to @prototype" do
          expect(assigns(:prototype)).to eq prototype
        end

        #prototypeの属性を変更しないこと
        it "does not save the new prototype" do
          expect(prototype.title).to eq "test"
        end

        #editテンプレートを再表示すること
        it "renders the :edit template" do
          expect(response).to redirect_to edit_prototype_path(prototype)
        end

        #更新失敗のflashメッセージが出ること
        it "shows flash message to show update prototype unsuccessfully" do
          expect(flash[:alert]).to eq "プロトタイプの更新に失敗しました"
        end

      end
    end

  end
end
