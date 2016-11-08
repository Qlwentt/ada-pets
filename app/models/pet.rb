class Pet < ActiveRecord::Base
	def as_json(options={})
		super(options.merge :only => [:id, :name, :human, :age])
	end
end
