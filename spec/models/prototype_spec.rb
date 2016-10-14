require 'rails_helper'

describe Prototype do
  #アソシエーションのテスト
  describe 'associations' do
    context 'with comments' do
      #prototypeが削除されたらコメントも削除
      let(:prototype) { create(:prototype) }
      it "deletes the comments when prototype is deleted" do
        prototype.destroy
        expect( prototype.images.empty? ).to eq true
      end
    end
    context 'with likes' do
      #prototypeが削除されたらlikeも削除
      let(:prototype) { create(:prototype, :with_likes) }
      it "deletes the likes when prototype is deleted" do
        prototype.destroy
        expect( prototype.likes.count ).to eq 0
      end
    end
  end
  #バリデーションのテスト
  describe 'validations' do
    context 'with valid attributes' do
      #バリデーション全部通ったらok
      it "has a valid factory" do
        expect(build(:prototype)).to be_valid
      end
    end
    context 'without valid attributes' do
      #タイトルないとダメ
      it "is missing a title" do
        prototype = build(:prototype, :is_missing_a_title)
        prototype.valid?
        expect(prototype.errors[:title]).to include("can't be blank")
      end
      #キャッチコピーないとダメ
      it "is missing a catch_copy" do
        prototype = build(:prototype, :is_missing_a_catch_copy)
        prototype.valid?
        expect(prototype.errors[:catch_copy]).to include("can't be blank")
      end
      #コンセプトないとダメ
      it "is missing a concept" do
        prototype = build(:prototype, :is_missing_a_concept)
        prototype.valid?
        expect(prototype.errors[:concept]).to include("can't be blank")
      end
    end
  end
end
