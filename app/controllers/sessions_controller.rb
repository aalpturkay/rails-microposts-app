class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: get_email.downcase)
    if user && user.authenticate(get_password)
      login user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end

  private

    def get_email
      params[:session][:email]
    end

    def get_password
      params[:session][:password]
    end
end
