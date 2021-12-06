class TJoboffer < ActiveRecord::Base
    belongs_to  :employer
    has_many :t_appliedjobs
    attr_accessible :employer_id, :title, :minsalary, :maxsalary, :location, :skills, :description, :category

    validates_presence_of :employer_id
    validates_presence_of :title, :location, :skills, :description, :category, :minsalary, :maxsalary
    
end
