class ApplicationController < ActionController::Base
	include Response
  	include ExceptionHandler
  	include SessionsHelper
    protect_from_forgery with: :exception
end
