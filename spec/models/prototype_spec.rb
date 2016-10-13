require 'rails_helper'

describe Prototype do
  #バリデーションのテスト
  describe 'validations' do
    describe 'with valid attributes' do
      #バリデーション全部通ったらok
      it "has a valid factory" do
        expect(build(:user)).to be_valid
      end
    end
    describe 'without valid attributes' do
      #タイトルないとダメ
      it "is missing a title" do
        prototype = build(:prototype, title: nil)
        prototype.valid?
        expect(prototype.errors[:title]).to include("can't be blank")
      end
      #キャッチコピーないとダメ
      it "is missing a catch_copy" do
        prototype = build(:prototype, catch_copy: nil)
        prototype.valid?
        expect(prototype.errors[:catch_copy]).to include("can't be blank")
      end
      #コンセプトないとダメ
      it "is missing a concept" do
        prototype = build(:prototype, concept: nil)
        prototype.valid?
        expect(prototype.errors[:concept]).to include("can't be blank")
      end
    end
  end
end
