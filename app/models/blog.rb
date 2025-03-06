class Blog < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :spot, optional: true
  has_one :thumbnail_image, class_name: 'Image', dependent: :destroy
  has_rich_text :body       # Action Text (リッチテキスト)
  enum status: { draft: 0, published: 1 } # statusをenumで定義

  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :spot_id, presence: true
  validates :status, presence: true

  # Ransack 用
  def self.ransackable_attributes(auth_object = nil)
    ["body", "category_id", "created_at", "id", "spot_id", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
      ["category", "spot", "user", "rich_text_body", "images_attachments"] # rich_text_body, images_attachments を追加
  end

  attr_accessor :spot_name

  before_save :set_spot_id

  private

  def set_spot_id
    return if self.spot_name.blank?

    self.spot = Spot.find_or_create_by(name: self.spot_name)
  end

  def optimized_content
    content.variant(resize_to_limit: [800, 800])
  end
end