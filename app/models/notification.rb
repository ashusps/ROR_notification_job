class Notification < ApplicationRecord

  validates :title, :content, :importance, :day, presence: true
  validates :tag, presence: true, uniqueness: true
  validate :validate_day

  belongs_to :user

  has_many :user_notifications, dependent: :destroy
  has_many :receivers, through: :user_notifications,  source: :user

  enum importance: %i[error warning info]

  def tag=(str)
    super(str.downcase)
  end

  def importance=(str)
    super(str.to_i)
  end

  def create_receivers! receiver_id
    user_notifications.destroy_all if user_notifications.any?
    params = receiver_id == 'all' ? User.all.map{|u| {user_id: u.id}} : {user_id: receiver_id}
    user_notifications.create!(params)
  end

  private

  def validate_day
    if day.present?
      errors.add(:day, 'must be a valid date-time') if !day&.is_a?(Time)
      errors.add(:day, 'must be a future date-time') if day <= Time.current
    end
  end
end
