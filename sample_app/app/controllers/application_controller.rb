class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #Session�w���p�[��ǂݍ���
  include SessionsHelper
  
  def hello
    render html: "oh..."
  end
end
