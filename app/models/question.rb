class Question < ApplicationRecord
  belongs_to :user
  belongs_to :spot, optional: true
  belongs_to :category, optional: true
  has_many :answers, dependent: :destroy

  attr_accessor :spot_name  # 仮想属性 spot_name を追加

  # バリデーション (必要に応じて)
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  before_save :set_spot_id  # 保存前に set_spot_id メソッドを実行

  private

  # spot_name から spot_id を設定するメソッド
  def set_spot_id
    return if self.spot_name.blank?  # spot_name が空なら何もしない

    # スポット名からSpotオブジェクトを検索。存在しなければ新規作成
    self.spot = Spot.find_or_create_by(name: self.spot_name)
  end
end
