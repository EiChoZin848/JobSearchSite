class EmployerMailer < ActionMailer::Base
    def employer_password_reset(employer)
        @employer = employer
        recipients   @employer.email
        from        "eichozin715@gmail.com"
        subject     "Change Your Password"
        sent_on     Time.now
        body        :employer => @employer
    end
end
