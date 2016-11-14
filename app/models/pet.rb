class Pet < ActiveRecord::Base

	validates :name, presence: true
	validates :human, presence: true
	validates :age, presence: true

	def as_json(options={})
		super(options.merge :only => [:id, :name, :human, :age])
	end
end
