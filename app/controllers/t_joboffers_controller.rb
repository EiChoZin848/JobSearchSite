class TJoboffersController < ApplicationController

  #before_filter :set_t_joboffer, :only => [:]
  before_filter :authenticate_employer, :only => [:create, :destroy]
  
  # GET /t_joboffers
  # GET /t_joboffers.xml
  def index
    @t_joboffers = TJoboffer.all(:order => 'created_at DESC').paginate(:page => params[:page], :per_page => 5)
    #@joboffer_count = TJoboffer.all
    #@t_search = TJoboffer.all #.find(params[:category], params[:location], params[:skills])
    @categories = TCategories.all
    @skills = TSkills.all
    @locations = TLocations.all
    @salaries = TSalaries.all
    
    #category
    if(params[:category].present? && params[:category] !="-")
      @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? ', "%#{params[:category]}%" ]).paginate(:page => params[:page], :per_page => 5) 
      if(params[:location].present? && params[:location] !="-") 
        @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ?', "%#{params[:category]}%",  "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5)  
        if (params[:skills].present? && params[:skills] !="-")
          @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%" , "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5) 
          if (params[:minsalary].present? && params[:minsalary] !="-")
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location=? and skills=? and minsalary=?', "%#{params[:category]}%", "%#{params[:location]}%" , "%#{params[:skills]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)
            if (params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ? and maxsalary LIKE ?', "%#{params[:category]}%","%#{params[:location]}%", "%#{params[:skills]}%", "%#{params[:minsalary]}%", "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)
            end
          end
        end
      end 
      if(params[:skills].present? && params[:skills] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and skills LIKE ?',  "%#{params[:category]}%",  "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)   
        if (params[:location].present? && params[:location] !="-")
          @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%" , "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
          if (params[:minsalary].present? && params[:minsalary] !="-")
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%" , "%#{params[:skills]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            if (params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers =TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ? and maxsalary LIKE ?',"%#{params[:category]}%","%#{params[:location]}%", "%#{params[:skills]}%", "%#{params[:minsalary]}%", "%#{params[:maxsalary]}%" ])
            end
          end
        end
      end
      if (params[:minsalary].present? && params[:minsalary] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ?',  "%#{params[:category]}%",  "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
        if(params[:skills].present? && params[:skills] != ["-"])
          @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ? and skills LIKE ?', "%#{params[:category]}%", "%#{params[:minsalary]}%" , "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)   
          if(params[:location].present? && params[:location] !="-") 
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ? and skills LIKE ? and location LIKE ?', "%#{params[:category]}%", "%#{params[:minsalary]}%" , "%#{params[:skills]}%" , "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5)   
            if(params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ? and skills LIKE ? and location LIKE ? and maxsalary LIKE ?', "%#{params[:category]}%", "%#{params[:minsalary]}%" , "%#{params[:skills]}%" , "%#{params[:location]}%" , "%#{params[:maxsalary]}%"]).paginate(:page => params[:page], :per_page => 5)   
            end
          end
        end
      end
      if (params[:maxsalary].present? && params[:maxsalary] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and maxsalary LIKE ?',  "%#{params[:category]}%",  "%#{params[:maxsalary]}%" ])
        if(params[:location].present? && params[:location] !="-") 
          @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and maxsalary LIKE ? and location LIKE ?', "%#{params[:category]}%",  "%#{params[:maxsalary]}%", "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5)  
          if(params[:skills].present? && params[:skills] != ["-"])
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and maxsalary LIKE ? and location LIKE ? and skills LIKE?', "%#{params[:category]}%",  "%#{params[:maxsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            if(params[:minsalary].present? && params[:minsalary]!=["-"])
              @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and maxsalary LIKE ? and location LIKE ? and skills LIKE? and minsalary LIKE ?', "%#{params[:category]}%",  "%#{params[:maxsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            end
          end
        end
      end
    end
   
    #location
    if(params[:location].present? && params[:location] !="-")
      @t_joboffers = TJoboffer.find(:all, :conditions => ['location LIKE? ', "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5)  
      if(params[:category].present? && params[:category] !="-") 
        @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%"]).paginate(:page => params[:page], :per_page => 5)  
        if (params[:skills].present? && params[:skills] !="-")
          @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%" , "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
          if (params[:minsalary].present? && params[:minsalary] !="-")
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%" , "%#{params[:skills]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5) 
            if  (params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ? and maxsalary LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%" , "%#{params[:skills]}%", "%#{params[:minsalary]}%" , "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5) 
            end
          end
        end
      end 
      if(params[:skills].present? && params[:skills] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['location LIKE ? and skills LIKE ?', "%#{params[:location]}%" , "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)   
        if (params[:category].present? && params[:category] !="-")
          @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:category]}%","%#{params[:location]}%" , "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)   
          if (params[:minsalary].present? && params[:minsalary] !="-")
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%" , "%#{params[:skills]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            if (params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers =TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ? and maxsalary LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%" , "%#{params[:skills]}%", "%#{params[:minsalary]}%" , "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            end
          end
        end
      end
      if (params[:minsalary].present? && params[:minsalary] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['location LIKE ? and minsalary LIKE ?', "%#{params[:location]}%" , "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
        if(params[:skills].present? && params[:skills] != ["-"])
          @t_joboffers = TJoboffer.find(:all, :conditions => ['location LIKE ? and minsalary LIKE ? and skills LIKE ? ',  "%#{params[:location]}%",  "%#{params[:minsalary]}%",  "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)   
          if(params[:category].present? && params[:category] !="-") 
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ? and skills LIKE ? and location LIKE ?', "%#{params[:category]}%", "%#{params[:minsalary]}%",  "%#{params[:skills]}%" , "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5)   
            if(params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ? and skills LIKE ? and location LIKE ? and maxsalary LIKE ?', "%#{params[:category]}%", "%#{params[:minsalary]}%",  "%#{params[:skills]}%" , "%#{params[:location]}%",  "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)   
            end
          end
        end
      end
      if (params[:maxsalary].present? && params[:maxsalary] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['location LIKE ? and maxsalary LIKE ?', "%#{params[:location]}%" , "%#{params[:maxsalary]}%" ])
        if(params[:category].present? && params[:category] !="-") 
          @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and maxsalary LIKE ? and location LIKE ?', "%#{params[:category]}%" , "%#{params[:maxsalary]}%", "%#{params[:location]}%"]).paginate(:page => params[:page], :per_page => 5)  
          if(params[:skills].present? && params[:skills] != ["-"])
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and maxsalary LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:category]}%" , "%#{params[:maxsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            if(params[:minsalary].present? && params[:minsalary]!=["-"])
              @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and maxsalary LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ?', "%#{params[:category]}%" , "%#{params[:maxsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%" ,"%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            end
          end
        end
      end
    end
  
    #skills
    if(params[:skills].present? && params[:skills] !="-")
      @t_joboffers = TJoboffer.find(:all, :conditions => ['skills LIKE? ', "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
      if (params[:minsalary].present? && params[:minsalary] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['skills LIKE ? and minsalary LIKE ?', "%#{params[:skills]}%",  "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
        if(params[:category].present? && params[:category] != ["-"])
          @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ? and skills LIKE ? ', "%#{params[:category]}%","%#{params[:minsalary]}%" , "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)   
          if(params[:location].present? && params[:location] !="-") 
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ? and skills LIKE ? and location LIKE ?', "%#{params[:category]}%","%#{params[:minsalary]}%" , "%#{params[:skills]}%"  , "%#{params[:location]}%"]).paginate(:page => params[:page], :per_page => 5)   
            if(params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ? and skills LIKE ? and location LIKE ? and maxsalary LIKE ?',  "%#{params[:category]}%","%#{params[:minsalary]}%" , "%#{params[:skills]}%"  , "%#{params[:location]}%" , "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)   
            end
          end
        end
        if(params[:maxsalary].present? && params[:maxsalary] !="-")
          @t_joboffers = TJoboffer.find(:all, :conditions => ['skills LIKE ? and minsalary LIKE ? and maxsalary LIKE ?', "%#{params[:skills]}%",  "%#{params[:minsalary]}%","%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
          if(params[:location].present? && params[:location] !="-") 
            @t_joboffers = TJoboffer.find(:all, :conditions => ['skills LIKE ? and minsalary LIKE ? and maxsalary LIKE ? and location LIKE ?', "%#{params[:skills]}%",  "%#{params[:minsalary]}%","%#{params[:maxsalary]}, %", "%#{params[:locaction]}, %" ]).paginate(:page => params[:page], :per_page => 5)  
            if(params[:category].present? && params[:category] != ["-"])
              @t_joboffers = TJoboffer.find(:all, :conditions => ['skills LIKE ? and minsalary LIKE ? and maxsalary LIKE ? and location LIKE ? and category LIKE ?', "%#{params[:skills]}%",  "%#{params[:minsalary]}%","%#{params[:maxsalary]}, %", "%#{params[:locaction]}, %", "%#{params[:category]}, %" ]).paginate(:page => params[:page], :per_page => 5)  
            end
          end
        end
      end
      if (params[:maxsalary].present? && params[:maxsalary] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['skills LIKE ? and maxsalary LIKE ?', "%#{params[:skills]}%",  "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
        if(params[:location].present? && params[:location] !="-") 
          @t_joboffers = TJoboffer.find(:all, :conditions => ['skills LIKE ? and maxsalary LIKE ? and location LIKE ?', "%#{params[:skills]}%",  "%#{params[:maxsalary]}%" , "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5)  
          if(params[:category].present? && params[:category] != ["-"])
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and maxsalary LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:category]}%",  "%#{params[:maxsalary]}%" , "%#{params[:location]}%", "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            if(params[:minsalary].present? && params[:minsalary]!=["-"])
              @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and maxsalary LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ?', "%#{params[:category]}%",  "%#{params[:maxsalary]}%" , "%#{params[:location]}%", "%#{params[:skills]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            end
          end
        end
      end
      if(params[:location].present? && params[:location] !="-") 
        @t_joboffers = TJoboffer.find(:all, :conditions => ['skills LIKE ? and location LIKE ?', "%#{params[:skills]}%","%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5)  
        if (params[:category].present? && params[:category] !="-")
          @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%","%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
          if (params[:minsalary].present? && params[:minsalary] !="-")
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%","%#{params[:skills]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5) 
            if  (params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ? and maxsalary LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%","%#{params[:skills]}%", "%#{params[:minsalary]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5) 
            end
          end
        end
      end 
      if(params[:category].present? && params[:category] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and skills LIKE ?', "%#{params[:category]}%",  "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)   
        if (params[:location].present? && params[:location] !="-")
          @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:category]}%","%#{params[:location]}%" , "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)   
          if (params[:minsalary].present? && params[:minsalary] !="-")
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%","%#{params[:skills]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            if (params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers =TJoboffer.find(:all, :conditions =>  ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ? and maxsalary LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%","%#{params[:skills]}%", "%#{params[:minsalary]}%", "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            end
          end
        end
      end

     
    end

    #minsalary
    if(params[:minsalary].present? && params[:minsalary] !="-")
      @t_joboffers = TJoboffer.find(:all, :conditions => ['minsalary LIKE ?',"%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
      if (params[:maxsalary].present? && params[:maxsalary] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['minsalary LIKE ? and maxsalary LIKE ?', "%#{params[:minsalary]}%",  "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        if(params[:location].present? && params[:location] !="-") 
          @t_joboffers = TJoboffer.find(:all, :conditions => ['minsalary LIKE ? and maxsalary LIKE ? and location LIKE ?', "%#{params[:minsalary]}%",  "%#{params[:maxsalary]}%", "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5) 
          if(params[:skills].present? && params[:skills] != ["-"])
            @t_joboffers = TJoboffer.find(:all, :conditions => ['minsalary LIKE ? and maxsalary LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:minsalary]}%",  "%#{params[:maxsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5) 
            if(params[:category].present? && params[:category]!=["-"])
              @t_joboffers = TJoboffer.find(:all, :conditions => ['minsalary LIKE ? and maxsalary LIKE ? and location LIKE ? and skills LIKE ? and category LIKE ?', "%#{params[:minsalary]}%",  "%#{params[:maxsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%", "%#{params[:category]}%" ]).paginate(:page => params[:page], :per_page => 5) 
            end
          end
        end
      end
      if(params[:skills].present? && params[:skills] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['minsalary LIKE ? and skills LIKE ?', "%#{params[:minsalary]}%",  "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
        if (params[:location].present? && params[:location] !="-")
          @t_joboffers = TJoboffer.find(:all, :conditions => ['minsalary LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:minsalary]}%" , "%#{params[:location]}%",  "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
          if (params[:category].present? && params[:category] !="-")
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%",  "%#{params[:skills]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5) 
            if (params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers =TJoboffer.find(:all, :conditions => ['category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ? and maxsalary LIKE ?', "%#{params[:category]}%", "%#{params[:location]}%",  "%#{params[:skills]}%", "%#{params[:minsalary]}%", "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5) 
            end
          end
        end
      end
      if(params[:location].present? && params[:location] !="-") 
        @t_joboffers = TJoboffer.find(:all, :conditions => ['minsalary LIKE ? and location  LIKE ?', "%#{params[:minsalary]}%", "%#{params[:location]}%"]) .paginate(:page => params[:page], :per_page => 5)  
        if (params[:skills].present? && params[:skills] !="-")
          @t_joboffers = TJoboffer.find(:all, :conditions => ['minsalary LIKE ? and location  LIKE ? and skills LIKE ?', "%#{params[:minsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)   
          if (params[:category].present? && params[:category] !="-")
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location  LIKE ? and skills LIKE ? and minsalary LIKE ?',  "%#{params[:category]}%" , "%#{params[:minsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            if  (params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and location  LIKE ? and skills LIKE ? and minsalary LIKE ? and maxsalary LIKE ?', "%#{params[:category]}%" , "%#{params[:minsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%", "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            end
          end
        end
      end 

      if (params[:category].present? && params[:category] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ?', "%#{params[:category]}%",  "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5) 
        if(params[:skills].present? && params[:skills] != ["-"])
          @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ? and skills LIKE ? ', "%#{params[:category]}%",  "%#{params[:minsalary]}%", "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
          if(params[:location].present? && params[:location] !="-") 
            @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ? and skills LIKE ? and location LIKE ?', "%#{params[:category]}%",  "%#{params[:minsalary]}%", "%#{params[:skills]}%" , "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            if(params[:maxsalary].present? && params[:maxsalary] !="-")
              @t_joboffers = TJoboffer.find(:all, :conditions => ['category LIKE ? and minsalary LIKE ? and skills LIKE ? and location LIKE ? and maxsalary LIKE ?', "%#{params[:category]}%",  "%#{params[:minsalary]}%", "%#{params[:skills]}%" , "%#{params[:location]}%", "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            end
          end
        end
      end
      
    end

    #maxsalary
    if(params[:maxsalary].present? && params[:maxsalary] !="-")
      @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary LIKE ? ', "%#{params[:maxsalary]}%"]).paginate(:page => params[:page], :per_page => 5)  
      if(params[:location].present? && params[:location] !="-") 
        @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary LIKE ? and location LIKE ?',"%#{params[:maxsalary]}%", "%#{params[:location]}%"]).paginate(:page => params[:page], :per_page => 5)   
        if (params[:skills].present? && params[:skills] !="-")
          @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:maxsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)   
          if (params[:minsalary].present? && params[:minsalary] !="-")
            @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ?', "%#{params[:maxsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            if  (params[:category].present? && params[:category] !="-")
              @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ? and category LIKE ? ', "%#{params[:maxsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%", "%#{params[:minsalary]}%","%#{params[:category]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            end
          end
        end
      end 
      if(params[:skills].present? && params[:skills] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary LIKE ? and skills LIKE ?', "%#{params[:maxsalary]}%",  "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)   
        if (params[:location].present? && params[:location] !="-")
          @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary LIKE ? and skills LIKE ? and location LIKE ?',  "%#{params[:maxsalary]}%",  "%#{params[:skills]}%", "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5)   
          if (params[:minsalary].present? && params[:minsalary] !="-")
            @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary LIKE ? and skills LIKE ? and location LIKE ? and minsalary LIKE ?', "%#{params[:maxsalary]}%",  "%#{params[:skills]}%", "%#{params[:location]}%", "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            if (params[:category].present? && params[:category] !="-")
              @t_joboffers =TJoboffer.find(:all, :conditions => ['maxsalary LIKE ? and skills LIKE ? and location LIKE ? and minsalary LIKE ? and category LIKE ?', "%#{params[:maxsalary]}%",  "%#{params[:skills]}%", "%#{params[:location]}%", "%#{params[:minsalary]}%", "%#{params[:category]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            end
          end
        end
      end

      if (params[:category].present? && params[:category] !="-")
        @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary  LIKE ? and category LIKE ?', "%#{params[:category]}%",  "%#{params[:maxsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
        if(params[:location].present? && params[:location] !="-") 
          @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary  LIKE ? and category LIKE ? and location LIKE ?',"%#{params[:category]}%",  "%#{params[:maxsalary]}%", "%#{params[:location]}%" ]).paginate(:page => params[:page], :per_page => 5)  
          if(params[:skills].present? && params[:skills] != ["-"])
            @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary  LIKE ? and category LIKE ? and location LIKE ? and skills LIKE ?', "%#{params[:category]}%",  "%#{params[:maxsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            if(params[:minsalary].present? && params[:minsalary]!=["-"])
              @t_joboffers = TJoboffer.find(:all, :conditions => ['maxsalary  LIKE ? and category LIKE ? and location LIKE ? and skills LIKE ? and minsalary LIKE ?', "%#{params[:category]}%",  "%#{params[:maxsalary]}%", "%#{params[:location]}%", "%#{params[:skills]}%" , "%#{params[:minsalary]}%" ]).paginate(:page => params[:page], :per_page => 5)  
            end
          end
        end
      end
    end

    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @t_joboffers }
    end
  end

  # GET /t_joboffers/1
  # GET /t_joboffers/1.xml
  def show
    @t_joboffer = TJoboffer.find(params[:id])
    @t_appliedjob = TAppliedjob.new
    if signed_in_jobseeker? 
      @already_applied = TAppliedjob.find(:all, :conditions => ['jobseeker_id=? and t_joboffers_id=? ', current_jobseeker.id, params[:id] ]) 
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @t_joboffer }
    end
  end

  # GET /t_joboffers/new
  # GET /t_joboffers/new.xml
  def new
    @t_joboffer = current_employer.t_joboffers.build #TJoboffer.new
    @categories = TCategories.all
    @skills = TSkills.all
    @locations = TLocations.all
    @salaries = TSalaries.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @t_joboffer }
    end
  end

  # GET /t_joboffers/1/edit
  def edit
    @t_joboffer = TJoboffer.find(params[:id])
  end

  # POST /t_joboffers
  # POST /t_joboffers.xml
  def create
    @t_joboffer = current_employer.t_joboffers.build(params[:t_joboffer]) #TJoboffer.new(params[:t_joboffer])
    
    respond_to do |format|
      if @t_joboffer.save
        format.html { redirect_to(t_joboffer_path(@t_joboffer), :notice => 'TJoboffer was successfully created.') }
        format.xml  { render :xml => @t_joboffer, :status => :created, :location => @t_joboffer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @t_joboffer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /t_joboffers/1
  # PUT /t_joboffers/1.xml
  def update
    @t_joboffer = TJoboffer.find(params[:id])

    respond_to do |format|
      if @t_joboffer.update_attributes(params[:t_joboffer])
        format.html { redirect_to(@t_joboffer, :notice => 'TJoboffer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @t_joboffer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /t_joboffers/1
  # DELETE /t_joboffers/1.xml
  def destroy
    #@t_joboffer = TJoboffer.find(params[:id])
    
    @t_joboffer = TJoboffer.find(params[:id])
    @t_joboffer.destroy

    respond_to do |format|
      format.html { redirect_to(t_joboffers_url) }
      format.xml  { head :ok }
    end
  end
end
