class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many :images , dependent: :destroy
  has_many :likes , dependent: :destroy
  has_many :comments , dependent: :destroy

  #画像を投稿している時のみimageインスタンスを作る。
  accepts_nested_attributes_for :images, reject_if: proc { |attributes| attributes["image"].blank?}

  validates :title, :catch_copy, :concept, presence: true
  #メイン画像は必須
  validate :must_main_image
  def must_main_image
    unless self.images.select{ |i| i.main? }.count == 1
      errors.add(:image, "メイン画像を投稿してください")
    end
  end

  paginates_per 8  # 1ページあたり8項目表示

end
