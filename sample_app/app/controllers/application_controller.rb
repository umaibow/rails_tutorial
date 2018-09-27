class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #Sessionƒwƒ‹ƒp[‚ð“Ç‚Ýž‚Þ
  include SessionsHelper
  
  def hello
    render html: "oh..."
  end
end
