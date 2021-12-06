class EmployerNewPasswordController < ApplicationController
  before_filter :authenticate_employer


  def edit
    @employer = current_employer
  end

  def update
    #@employer = current_employer
    #if @employer.update_attributes(params[:password])
    #  sign_in_employer @employer, :bypass => true
    #  redirect_to root_path, :notice => "Your Password has been updated!"

    #end

    @employer = current_employer
    if @employer.update_with_password(params[:employer])
      sign_in_employer @employer, :bypass => true
      redirect_to search_job_path, :notice => "Your Password has been updated!"
    else
      render 'edit'
    end
  end

end
