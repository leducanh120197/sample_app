class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save :email_downcase
  has_secure_password

  validates :name, presence: true,
   length: {maximum: Settings.user_validates.name_max_length}
  validates :email, presence: true,
   length: {maximum: Settings.user_validates.email_max_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
   length: {minimum: Settings.user_validates.password_min_length}

  private

  def email_downcase
    email.downcase!
  end
end
