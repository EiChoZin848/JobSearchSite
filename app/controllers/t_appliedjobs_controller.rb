class TAppliedjobsController < ApplicationController
  # GET /t_appliedjobs
  # GET /t_appliedjobs.xml
  def index
    @t_appliedjobs = TAppliedjob.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @t_appliedjobs }
    end
  end

  # GET /t_appliedjobs/1
  # GET /t_appliedjobs/1.xml
  def show
    @t_appliedjob = TAppliedjob.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @t_appliedjob }
    end
  end

  # GET /t_appliedjobs/new
  # GET /t_appliedjobs/new.xml
  def new
    @t_appliedjob = TAppliedjob.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @t_appliedjob }
    end
  end

  # GET /t_appliedjobs/1/edit
  def edit
    @t_appliedjob = TAppliedjob.find(params[:id])
  end

  # POST /t_appliedjobs
  # POST /t_appliedjobs.xml
  def create
    @t_appliedjob = TAppliedjob.new(params[:t_appliedjob])
    #@t_appliedjob[:t_joboffers_id] = params[:t_joboffers_id]
    @t_appliedjob[:jobseeker_id] = current_jobseeker.id #params[:session][:jobseeker_id]
      if @t_appliedjob.save
       redirect_to t_joboffer_path(params[:t_appliedjob][:t_joboffers_id])
      else
         render :action => "new" 
        #format.xml  { render :xml => @t_appliedjob.errors, :status => :unprocessable_entity }
      end
   
  end

  # PUT /t_appliedjobs/1
  # PUT /t_appliedjobs/1.xml
  def update
    @t_appliedjob = TAppliedjob.find(params[:id])

    respond_to do |format|
      if @t_appliedjob.update_attributes(params[:t_appliedjob])
        format.html { redirect_to(@t_appliedjob, :notice => 'TAppliedjob was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @t_appliedjob.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /t_appliedjobs/1
  # DELETE /t_appliedjobs/1.xml
  def destroy
    @t_appliedjob = TAppliedjob.find(params[:id])
    @t_appliedjob.destroy

    respond_to do |format|
      format.html { redirect_to(t_appliedjobs_url) }
      format.xml  { head :ok }
    end
  end
end
