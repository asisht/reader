class FeedsController < ApplicationController
	
	def index
		@feeds = Feed.order(created_at: :desc)
		@feed = Feed.new

	end

	def new
		@feed = Feed.new
	end

	def create		
		begin
			@rss = SimpleRSS.parse open(feed_params[:link])
			
			@feed = Feed.new(:title=>@rss.feed.title,:link=>feed_params[:link])	
			if @feed.save
				@feeds = Feed.order(created_at: :desc)
				respond_to do |format|
					format.js
				end
			else
				error_msg = @feed.errors.messages[:link][0]
				render js:"alert('#{error_msg}');"
			end			
		rescue
			render js:"alert('Given URL is not valid !');"
		end
	end
	def edit
		@feed = Feed.where(:id=>params[:id]).first
		respond_to do |format|
			format.js
		end
	end

	def update
		@feed = Feed.where(:id=>params[:id]).first
		
		begin
			@rss = SimpleRSS.parse open(feed_params[:link])
			
			@feed.title = @rss.feed.title
			@feed.link = feed_params[:link]	
			if @feed.save
				respond_to do |format|
					format.js
				end
			else
				error_msg = @feed.errors.messages[:link][0]
				render js:"alert('#{error_msg}');"	
			end	
			
		#binding.pry
		rescue
			render js:"alert('Given URL is not valid !');"
		end
	end

	def show
		@feed = Feed.where(:id=>params[:id]).first
		@rss = SimpleRSS.parse open(@feed.link)
	end

	def destroy
		@feed = Feed.where(:id=>params[:id]).first.destroy
		redirect_to feeds_path
	end

	def cancel
		@feed = Feed.where(:id=>params[:id]).first
		respond_to do |format|
			format.js
		end	
	end

	protected
	
	def feed_params
    	params.require(:feed).permit!
  	end
end