class SessionsController < ApplicationController
  def new
  end

  def create
    #employer = Employer.find_by_email(params[:session][:email], params[:session][:password])
    #jobseeker = Jobseeker.find_by_email(params[:session][:email], params[:session][:password])
    
    #jobseeker = Jobseeker.authenticate(params[:session][:email], params[:session][:password])
    #employer = Employer.authenticate(params[:session][:email], params[:session][:password])

    employer = Employer.find_by_email(params[:session][:email].downcase)
    jobseeker = Jobseeker.find_by_email(params[:session][:email].downcase)



    if employer && Employer.authenticate(params[:session][:email], params[:session][:password]) # == Jobseeker.authenticate(params[:session][:email], params[:session][:password])
          #Sign the user in and redirect to the user's show page
          sign_in_employer employer
          redirect_to employer
    
    elsif jobseeker && Jobseeker.authenticate(params[:session][:email], params[:session][:password]) # == Jobseeker.authenticate(params[:session][:email], params[:session][:password])
      #Sign the user in and redirect to the user's show page
      sign_in_jobseeker jobseeker
      redirect_to jobseeker
          
    else
       #create error message and re-render the signin form
       flash.now[:error_messages] = "Invalid email/password combination."
       render 'new'
    end
  end

  def destroy_employer
    sign_out_employer
    redirect_to root_path
  end

  def destroy_jobseeker
    sign_out_jobseeker
    redirect_to root_path
  end
end
