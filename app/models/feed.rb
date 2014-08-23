class Feed < ActiveRecord::Base
	validates :link , presence: { message:"Enter valid link!"} , uniqueness: { message:"Link is already in the list. Its not unique !"}
end
