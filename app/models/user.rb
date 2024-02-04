class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :acknowledgement

  validates :name, presence: true
  validates :acknowledgement, acceptance: { message: I18n.t(:acknowledgement, scope: %i[devise failure]) }, on: :create

  enum role: {
    user: 0,
    admin: 1
  }
end
