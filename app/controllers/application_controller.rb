class ApplicationController < ActionController::Base
	require 'rubygems'
	require 'simple-rss'
	require 'open-uri'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
