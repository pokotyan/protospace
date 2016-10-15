require 'rails_helper'

describe User do
  #ユーザー作成時のバリデーションのテスト
  describe '#create' do
    context 'with valid attributes' do
      #全て属性が有効だったらバリデーションが通ること
      let(:user) { build(:user) }
      it "is valid with all information" do
        expect(user).to be_valid
      end
    end
    context 'without valid attributes' do
      #名前は必須なのでnilだとバリデーション通らないこと
      it "is invalid without a name" do
        user = build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end
      #emailは必須なのでnilだとバリデーション通らないこと
      it "is invalid without an email" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end
      #パスワードは必須なのでnilだとバリデーション通らないこと
      it "is invalid without a password" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end
      #誰かと同じemailアドレスは許可しない
      it "is invalid with a duplicate email address" do
        first_user = create(:user, email: "test@gmail.com")
        second_user = build(:user, email: "test@gmail.com")
        second_user.valid?
        expect(second_user.errors[:email]).to include("has already been taken")
      end
      #パスワード文字数が７文字未満は無効
      it "is invalid with a password that has less than 7 characters" do
        user = build(:user, password: "000000")
        user.valid?
        expect(user.errors[:password][0]).to eq "is too short (minimum is 7 characters)"
      end
    end
  end
end
