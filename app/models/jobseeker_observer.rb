def JoseekerObserver < ActiveRecord::Observer
    def after_create(jobseeker)
        JobseekerMailer.deliver_jobseeker_password_reset(jobseeker)
    end
end