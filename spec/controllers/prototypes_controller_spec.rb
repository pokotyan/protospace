require 'rails_helper'

describe PrototypesController do

  describe 'with user login' do
    describe 'GET #index' do
      #作成されたprototypeたちが@prototypesに格納されていること
      it "assigns the requested prototypes to @prototypes" do
        prototype1 = create(:prototype_with_main_image, title: "test1")
        prototype2 = create(:prototype_with_main_image, title: "test2")
        get :index
        expect(assigns(:prototypes).map{|prototype| prototype["title"] }.flatten).to match_array(["test1","test2"])
      end
      #GET #indexでindexテンプレートを表示すること
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
