class Review < ActiveRecord::Base
	belongs_to :place
	belongs_to :user

	validates_presence_of :score
	validates_presence_of :content

	after_save :calculate_average

	def calculate_average
		rating_value = self.place.average_rating
		self.place.update_attributes(total_average_rating: rating_value)
	end
end
