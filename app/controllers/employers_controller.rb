class EmployersController < ApplicationController
  before_filter :authenticate_employer, :only => [ :edit, :update, :update_password]
  # GET /employers
  # GET /employers.xml
  def index
    @employers = Employer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @employers }
    end
  end

  # GET /employers/1
  # GET /employers/1.xml
  def show
    @employer = Employer.find(params[:id])
    @t_joboffers = TJoboffer.all(:order => 'created_at DESC').paginate(:page => params[:page], :per_page => 5)

   
    @already_offered = TJoboffer.find(:all, :conditions => ['employer_id=? ', current_employer.id ]).paginate(:page => params[:page], :per_page => 5) 
    

    #@t_joboffers = @employer.t_joboffers.paginate(:page => params[:page], :per_page => 2)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @employer }
    end
  end

  # GET /employers/new
  # GET /employers/new.xml
  def new
    @employer = Employer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @employer }
    end
  end

  # GET /employers/1/edit
  def edit
    @employer = current_employer
    @locations = TLocations.all
  end

  # POST /employers
  # POST /employers.xml
  def create
    @employer = Employer.new(params[:employer])
    @locations = TLocations.all
    respond_to do |format|
      if @employer.save
        sign_in_employer @employer
        format.html { redirect_to(@employer, :notice => 'Employer was successfully created.') }
        format.xml  { render :xml => @employer, :status => :created, :location => @employer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /employers/1
  # PUT /employers/1.xml
  def update
    @employer = current_employer

 
      if (@employer.update_attribute(:name, params[:employer][:name]) &&
           @employer.update_attribute(:phone, params[:employer][:phone]) &&
           @employer.update_attribute(:address, params[:employer][:address]) &&
           @employer.update_attribute(:location, params[:employer][:location]) &&
          @employer.update_attribute(:info, params[:employer][:info]) &&
          @employer.update_attribute(:profile, params[:employer][:profile]) )
        #if @employer.update_attributes(params[:employer])
        #format.html { redirect_to employer, :notice => 'Employer was successfully updated.' }
        redirect_to @employer
        #format.xml  { head :ok }
      else
        render :action => "edit"
        #format.html { render :action => "edit" }
        #format.xml  { render :xml => @employer.errors, :status => :unprocessable_entity }
      end
    
  end

  # DELETE /employers/1
  # DELETE /employers/1.xml
  def destroy
    @employer = Employer.find(params[:id])
    @employer.destroy

    respond_to do |format|
      format.html { redirect_to(employers_url) }
      format.xml  { head :ok }
    end
  end

  def update_password
    @employer = current_employer #Employer.find_by_email(params[:employer][:email])
    if params[:password]==params[:password_confirmation]
      if params[:current_employer_password]==@employer[:password]

        if @employer.update_attributes(params[:employer])
          redirect_to @employer
        else
          render :action =>"update_password", :notice=> 'current password is not equal.'
        end
      else
        
        render "update_password"
      end
    else  
        
        render "update_password", :notice=> 'password and password confirmation is not equal.'
    end
  end

  private
    def update_employer
      params.require(:employer).permit(:name, :phone, :address, :location, :info, :profile)
    end
end

