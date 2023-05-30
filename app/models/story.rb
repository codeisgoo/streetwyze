class Story < ApplicationRecord
  belongs_to :asser
  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :by_type_of_stuff, ->(type_of_stuff) { where(type_of_stuff: type_of_stuff) if type_of_stuff.present? }
  scope :with_media, -> { where.not(media: nil) }
  scope :created_today, -> { where("created_at >= ?", Time.zone.today.beginning_of_day) }
  scope :created_yesterday, -> { where(created_at: Time.zone.yesterday.all_day) }
  scope :created_last_7_days, -> { where(created_at: 7.days.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_30_days, -> { where(created_at: 30.days.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_this_month, -> { where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }
  scope :created_last_month, -> { where(created_at: 1.month.ago.beginning_of_month..1.month.ago.end_of_month) }
  scope :created_within_range, ->(start_date, end_date) { where(created_at: start_date..end_date) if start_date.present? && end_date.present? }


  def self.to_csv(stories)
    CSV.generate(headers: true) do |csv|
      csv << ['Place Name', 'Address', 'Type of Stuff', 'Category', 'Rating', 'Story Description', 'Created At']

      stories.each do |story|
        csv << [
          story.place_name,
          story.address,
          story.type_of_stuff,
          story.category,
          story.rating,
          story.story_description,
          story.created_at
        ]
      end
    end
  end



end
