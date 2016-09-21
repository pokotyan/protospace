class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many :images , dependent: :destroy

  #画像を投稿している時のみimageインスタンスを作る。
  #reject_ifがないと画像を投稿してなくても常に3つのimageインスタンスが出来てしまう。(nullのimageインスタンスができてしまう)
  accepts_nested_attributes_for :images, reject_if: proc { |attributes| attributes["image"].blank?}
  ##備忘録
  # "１枚も" 画像を投稿せずsubmitするとメイン画像がないため投稿は失敗する。で、reject_ifによりimageインスタンスは一つも作られない。
  #renderにより、imageインスタンスが一つもない状態が継承されたまま、newページに差し戻る。
  #すると、f.fields_for内のimage.file_field がimageインスタンスがないため効かない状態となり画像の投稿ができなくなる。
  #そうなるとページのリロードが必要。
  #そういう状態を防ぐためにメイン画像投稿フォームにrequired: trueを設定する。
  #そうすればimageインスタンスが必ずある状態でsubmitすることになるので、
  #もし投稿失敗、renderでnewページに差し戻っても、imageインスタンスはある状態なので画像の再投稿ができる。

  validates :title, :catch_copy, :concept, presence: true
  #メイン画像は必須
  validate :must_main_image
  def must_main_image
    unless self.images.select{ |i| i.main? }.count == 1
      errors.add(:image, "メイン画像を投稿してください")
    end
  end

end
