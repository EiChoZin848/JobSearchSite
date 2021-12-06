class TAppliedjob < ActiveRecord::Base
    belongs_to :jobseeker
    belongs_to :t_joboffer
    attr_accessible :t_joboffers_id, :jobseeker_id
    #validates_uniqueness_of :t_joboffers_id, :scope => :jobseeker_id
end
