# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
  end

  def create
    session["email"] = params[:email]
    session["password"] = params[:password]

    user = User.find_by(email: session[:email].downcase)

    if user && user.authenticate(session[:password])
      log_in user
      session[:remember_me] == "1" ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
