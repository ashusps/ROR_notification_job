class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :notifications, dependent: :destroy
  has_many :user_notifications
  has_many :received_notifications, through: :user_notifications, source: :notification
end
