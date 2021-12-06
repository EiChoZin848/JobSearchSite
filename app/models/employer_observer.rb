def EmployerObserver < ActiveRecord::Observer 
    def after_create(employer)
        EmployerMailer.deliver_employer_password_reset(employer)
    end
end