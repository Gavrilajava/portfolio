require 'uri'
class Url < ApplicationRecord
  before_validation :set_timestamps
  validate :long_is_a_valid_url

  def save(*_args)
    return false unless valid?

    result = self.class.upsert(attributes.except(*%w[id short]),
                               returning: %i[id short updated_at],
                               unique_by: :long,
                               record_timestamps: false,
                               update_only: [:updated_at])
    update_attributes_from_upsert_result(result)
  rescue StandardError => e
    errors.add(:base, e.message)
    false
  end

  private

  def update_attributes_from_upsert_result(result)
    return false unless result.first

    assign_attributes(result.first)
    true
  end

  def set_timestamps
    self.updated_at = Time.now
    self.created_at ||= Time.now
  end

  def long_is_a_valid_url
    uri = URI.parse(long)
    uri.is_a?(URI::HTTPS) && uri.host.present? || raise
  rescue StandardError
    errors.add(:long, 'Should be a valid and secure URL')
  end
end
