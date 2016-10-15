require 'rails_helper'

describe Prototype do
  #アソシエーションのテスト
  describe 'associations' do
    context 'with images' do
      #prototypeが削除されたら画像も削除
      let(:prototype) { create(:prototype_with_main_image) }
      it "deletes the images when prototype is deleted" do
        prototype.destroy
        expect( prototype.images.empty? ).to eq true
      end
    end
    context 'with likes' do
      #prototypeが削除されたらlikeも削除
      let(:prototype) { create(:prototype_with_main_image, :with_likes) }
      it "deletes the likes when prototype is deleted" do
        prototype.destroy
        expect( prototype.likes.count ).to eq 0
      end
    end
    context 'with comments' do
      #prototypeが削除されたらコメントも削除
      let(:prototype) { create(:prototype_with_main_image, :with_comments) }
      it "deletes the comments when prototype is deleted" do
        prototype.destroy
        expect( prototype.comments.empty? ).to eq true
      end
    end
  end
  #バリデーションのテスト
  describe 'validations' do
    context 'with valid attributes' do
      #バリデーション全部通ったらok
      it "has a valid factory" do
        expect(build(:prototype_with_main_image)).to be_valid
      end
    end
    context 'without valid attributes' do
      #タイトルないとダメ
      it "is missing a title" do
        prototype = build(:prototype_with_main_image, :is_missing_a_title)
        prototype.valid?
        expect(prototype.errors[:title]).to include("can't be blank")
      end
      #キャッチコピーないとダメ
      it "is missing a catch_copy" do
        prototype = build(:prototype_with_main_image, :is_missing_a_catch_copy)
        prototype.valid?
        expect(prototype.errors[:catch_copy]).to include("can't be blank")
      end
      #コンセプトないとダメ
      it "is missing a concept" do
        prototype = build(:prototype_with_main_image, :is_missing_a_concept)
        prototype.valid?
        expect(prototype.errors[:concept]).to include("can't be blank")
      end
    end
  end
  #sub画像を投稿したら
  describe '#set_sub_thumbnails ' do
    #sub画像を含む配列を返します。
    it "returns an array containing sub_images" do
      prototype = create(:prototype, :with_full_images)
      expect(prototype.images[1].status).to include("sub")
    end
  end
  #sub画像の拒否
  describe '#reject_sub_images(attributed)' do
    #sub画像が投稿されていなかったらsub画像を保存しない
    it "doesnt save a record with nil content" do
      prototype = create(:prototype_with_main_image)
      expect(prototype.images.count).to eq 1
    end
  end
end
