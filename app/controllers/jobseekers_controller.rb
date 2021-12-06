class JobseekersController < ApplicationController
  before_filter :authenticate, :only => [ :edit, :update, :update_password]
  # GET /jobseekers
  # GET /jobseekers.xml
  def index
    @jobseekers = Jobseeker.all(:order => 'created_at DESC').paginate(:page => params[:page], :per_page => 5)
    
    #@t_search_jobseeker = Jobseeker.all
    @categories = TCategories.all
    @skills = TSkills.all
    @locations = TLocations.all
   
      @jobseeker_search = Jobseeker.all

    
    if(params[:category].present? && params[:category] !="-")
      @jobseekers = Jobseeker.find(:all, :conditions => ['category LIKE ? ', "%#{params[:category]}%" ]).paginate(:page => params[:page], :per_page => 5) 

      if(params[:location].present? && params[:location] !="-") 
        @jobseekers = Jobseeker.find(:all, :conditions => ['category LIKE ? and location LIKE ?', "%#{params[:category]}%" , "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        if (params[:skills].present? && params[:skills] !="-")
          @jobseekers = Jobseeker.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%" , "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        end
      end 
      if(params[:skills].present? && params[:skills] !="-")
        @jobseekers = Jobseeker.find(:all, :conditions => ['category LIKE ? and skills LIKE ?', "%#{params[:category]}%",  "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)
        if(params[:location].present? && params[:location] !="-")
         @jobseekers = Jobseeker.find(:all, :conditions => ['category LIKE ? and skills LIKE ? and locaction LIKE ?', "%#{params[:category]}%",  "%#{params[:skills]}%", "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        end 
      end
    end
   
    if(params[:location].present? && params[:location] !="-")
      @jobseekers = Jobseeker.find(:all, :conditions => ['location LIKE ? ', "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5) 
      if (params[:skills].present? && params[:skills] !="-")
        @jobseekers = Jobseeker.find(:all, :conditions => ['location LIKE ? and skills LIKE ?', "%#{params[:location]}%" , "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        if(params[:category].present? && params[:category] !="-")
          @jobseekers = Jobseeker.find(:all, :conditions => ['location LIKE ? and skills LIKE ? and category LIKE ? ', "%#{params[:location]}%" , "%#{params[:skills]}%", "%#{params[:category]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        end
      end
      if(params[:category].present? && params[:category] !="-")
        @jobseekers = Jobseeker.find(:all, :conditions => ['location LIKE ? and category LIKE ?', "%#{params[:location]}%",  "%#{params[:category]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        if(params[:skills].present? && params[:skills] !="-")
          @jobseekers = Jobseeker.find(:all, :conditions => ['location LIKE ? and category LIKE ? and skills LIKE ?', "%#{params[:location]}%", "%#{params[:category]}%", "%#{params[:skills]}%"]).paginate(:page => params[:page], :per_page => 5) 
        end
      end
    end

    if(params[:skills].present? && params[:skills] !="-")
      
      @jobseekers = Jobseeker.find(:all, :conditions => ['skills LIKE ? ', "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
      if(params[:location].present? && params[:location] !="-") 
        @jobseekers = Jobseeker.find(:all, :conditions => ['skills LIKE ? and location LIKE ?',"%#{params[:skills]}%" , "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        if (params[:category].present? && params[:category] !="-")
          @jobseekers = Jobseeker.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:category]}%" , "%#{params[:location]}%", "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        end
      end 
      if(params[:category].present? && params[:category] !="-")
        @jobseekers = Jobseeker.find(:all, :conditions => ['category LIKE ? and skills LIKE ?',  "%#{params[:category]}%",  "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        if (params[:location].present? && params[:location] !="-")
          @jobseekers = Jobseeker.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ?',  "%#{params[:category]}%", "%#{params[:location]}%", "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        end
      end
    end
    #@t_joboffer = TJoboffers.new if signed_in?
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => index_jobseeker_path }
    end
  end


  # GET /jobseekers/1
  # GET /jobseekers/1.xml
  def show
    @jobseeker = Jobseeker.find(params[:id])
    @jobseeker_skills = Jobseeker.find(:all, :conditions => ['id=? and skills=?', params[:id], @jobseeker.skills ] )
    
    #@t_joboffer = @jobseeker.t_joboffers.paginate(:page => params[:page], :per_page => 2)
    @t_joboffers = TJoboffer.all(:order => 'created_at DESC')#.paginate(:page => params[:page], :per_page => 5)
    @t_appliedjob = TAppliedjob.all(:order => 'created_at DESC').paginate(:page => params[:page], :per_page => 5)
    @already_applied = TAppliedjob.find(:all, :conditions => ['jobseeker_id=? ', params[:id]]).paginate(:page => params[:page], :per_page => 5)
  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jobseeker }
    end
  end

  # GET /jobseekers/new
  # GET /jobseekers/new.xml
  def new
    @jobseeker = Jobseeker.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @jobseeker }
    end
  end

  # GET /jobseekers/1/edit
  def edit
    @jobseeker = current_jobseeker
    @categories = TCategories.all
    @skills = TSkills.all
    @locations = TLocations.all
  end

  # POST /jobseekers
  # POST /jobseekers.xml
  def create
    @jobseeker = Jobseeker.new(params[:jobseeker])

    respond_to do |format|
      if @jobseeker.save
        sign_in_jobseeker @jobseeker
        format.html { redirect_to(@jobseeker, :notice => 'Jobseeker was successfully created.') }
        format.xml  { render :xml => @jobseeker, :status => :created, :location => @jobseeker }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @jobseeker.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobseekers/1
  # PUT /jobseekers/1.xml
  def update
    @jobseeker = current_jobseeker
  
      
      if (@jobseeker.update_attribute(:name, params[:jobseeker][:name]) &&
          @jobseeker.update_attribute(:phone, params[:jobseeker][:phone]) &&
          @jobseeker.update_attribute(:category, params[:jobseeker][:category]) &&
          @jobseeker.update_attribute(:skills, params[:jobseeker][:skills]) &&
          @jobseeker.update_attribute(:about, params[:jobseeker][:about]) &&
          @jobseeker.update_attribute(:location, params[:jobseeker][:location]) &&
          @jobseeker.update_attribute(:profile, params[:jobseeker][:profile]) )
          #if @jobseeker.update_attributes(params[:jobseeker])
        #format.html { redirect_to(@jobseeker, :notice => 'Jobseeker was successfully updated.') }
        #format.xml  { head :ok }
        redirect_to @jobseeker
      else
        render :action => "edit"
        #format.html { render :action => "edit" }
        #format.xml  { render :xml => @jobseeker.errors, :status => :unprocessable_entity }
      end
  
  end

  # DELETE /jobseekers/1
  # DELETE /jobseekers/1.xml
  def destroy
    @jobseeker = Jobseeker.find(params[:id])
    @jobseeker.destroy
    #Jobseeker.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(jobseekers_url) }
      format.xml  { head :ok }
    end
  end

  def update_password
    @jobseeker = current_jobseeker#Employer.find_by_email(params[:employer][:email])
    if params[:password]==params[:password_confirmation]
      if params[:current_jobseeker_password]==@jobseeker[:password]

        if @jobseeker.update_attributes(params[:jobseeker])
          redirect_to @jobseeker
          flash.now[:success] = "Your password have been changed."
        else
          render :action =>"update_password"
          
        end
      else
        
        render "update_password"
        flash.now[:notice]= "Current password is incorrect"
      end
    else  
        
        render "update_password"
        flash.now[:notice]="Password and Password confirmation is not equal."
    end
  end
  private
    def jobseeker_params
      params.require(:jobseeker).permit(:name, :phone, :category, :skills, :about, :location)
    end
end
