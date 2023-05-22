class Asser < ApplicationRecord
  has_many :stories
  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :by_type, ->(type) { where(type: type) if type.present? }
  scope :with_media, -> { where.not(media: nil) }
  scope :without_media, -> { where(media: nil) }
  scope :by_author, ->(user_id) { where(user_id: user_id) if user_id.present? }
  scope :created_today, -> { where("created_at >= ?", Time.zone.today.beginning_of_day) }
  scope :created_yesterday, -> { where(created_at: Time.zone.yesterday.all_day) }
  scope :created_last_7_days, -> { where(created_at: 7.days.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_30_days, -> { where(created_at: 30.days.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_this_month, -> { where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }
  scope :created_last_month, -> { where(created_at: 1.month.ago.beginning_of_month..1.month.ago.end_of_month) }
  scope :created_within_range, ->(start_date, end_date) { where(created_at: start_date..end_date) if start_date.present? && end_date.present? }
end
