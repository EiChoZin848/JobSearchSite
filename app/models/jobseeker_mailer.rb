class JobseekerMailer < ActionMailer::Base
    def jobseeker_password_reset(jobseeker)
        @jobseeker = jobseeker
        recipients   @jobseeker.email
        from        "eichozin715@gmail.com"
        subject     "Change Your Password"
        sent_on     Time.now
        body        :jobseeker => @jobseeker
    end
end
