class ApplicationController < ActionController::Base
  if Rails.env == 'production'
    username = ENV["BASIC_USERNAME"]
    password = ENV["BASIC_PASSWORD"]
    raise "Total brutal lack of configuration, security kitty is not pleased :(" unless username.present? && password.present?
    http_basic_authenticate_with name: username, password: password
  end
end
