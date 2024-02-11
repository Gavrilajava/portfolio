class ContactRequest < ApplicationRecord
  enum status: {
    created: 0,
    in_progress: 1,
    archived: 99
  }
  validates :email, presence: true
end
