class PasswordResetTokensController < ApplicationController
  before_filter :get_employer, :only => [:edit, :update]
  before_filter :get_jobseeker, :only => [:edit, :update]
  def new
  end

  def create
    @employer = Employer.find_by_email(params[:password_reset_tokens][:email].downcase)
    @jobseeker = Jobseeker.find_by_email(params[:password_reset_tokens][:email].downcase)

    if @employer 
      EmployerMailer.deliver_employer_password_reset(@employer)
      #@employer.send_password_reset_tokens_email
      flash[:info] = "Email sent with password reset instructions."
      redirect_to root_url
    elsif @jobseeker
      JobseekerMailer.deliver_jobseeker_password_reset(@jobseeker)
      flash[:info] = "Email sent with password reset instructions "
      redirect_to root_url
    else 
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end
      
  def edit
    
  end

  def update
    test = params[:test] 
    
    if test == "1" 
      
      if params[:employer][:password].empty?
        @employer.errors.add(:password, "can't be empty")
        render 'edit'
      elsif @employer.update_attributes(params[:employer])
        sign_in_employer @employer
        flash[:success] = "Password has been reset."
        redirect_to @employer
      else
        render 'edit'
      end
    

    
    elsif params[:test] == "2"
      
      if params[:jobseeker][:password].empty?
        @jobseeker.errors.add(:password, "can't be empty")
        render 'edit'
      
      elsif @jobseeker.update_attributes(params[:jobseeker])
          sign_in_jobseeker @jobseeker
          flash[:success] = "Password has been reset."
          redirect_to @jobseeker
        
      else
        render 'edit'
      end
    else
      render 'edit'
    
    end
 
  end


  private
    def get_employer
      @employer = Employer.find(params[:id])
    end
    def get_jobseeker
      @jobseeker = Jobseeker.find(params[:id])
    end
end
