require 'rails_helper'

describe Image do
  #画像保存のテスト
  describe '#create' do
    #フォーマットが画像（jpg, jpeg, gif, png）ではないときは保存しない
    let(:image) { build(:wrong_content ) }
    it "has the wrong content format" do
      image.valid?
      expect(image.errors[:image][0]).to include("allowed types: jpg, jpeg, gif, png")
    end
    #有効な属性であればバリデーション通る。
    context 'with valid attributes' do
      it "has a valid factory" do
        expect(build(:main_image)).to be_valid
      end
    end
    #imageカラムは必須なのでnilだとバリデーション通らない。
    context 'without content attribute' do
      it "returns error" do
        image = build(:image, image: nil)
        image.valid?
        expect(image.errors[:image]).to include("can't be blank")
      end
    end
    #statusカラムは必須なのでnilだとバリデーション通らない。
    context 'without status attribute' do
      it "returns error" do
        image = build(:image, status: nil)
        image.valid?
        expect(image.errors[:status]).to include("can't be blank")
      end
    end
  end
end
