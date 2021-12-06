module SessionsHelper
    def sign_in_jobseeker(jobseeker)
        cookies.permanent.signed[:jobseeker_remember_token] = [jobseeker.id, jobseeker.salt]
        current_jobseeker = jobseeker
    end

    def sign_in_employer(employer)
        cookies.permanent.signed[:employer_remember_token] = [employer.id, employer.salt]
        current_employer = employer
    end

    def current_jobseeker=(jobseeker)
        @current_jobseeker = jobseeker
    end

    def current_employer=(employer)
        @current_employer = employer
    end

    def current_jobseeker
        @current_jobseeker ||= jobseeker_from_remember_token
    end

    def current_employer
        @current_employer ||= employer_from_remember_token
    end

    def signed_in_jobseeker?
        !current_jobseeker.nil? 
    end
    def signed_in_employer?
        !current_employer.nil?
    end



    def sign_out_employer
        cookies.delete(:employer_remember_token)
        current_employer = nil
    end


    def sign_out_jobseeker
        cookies.delete(:jobseeker_remember_token)
        current_employer = nil
    end

    def current_employer?(employer)
        employer == current_employer
    end

    def current_jobseeker?(jobseeker)
        employer == current_jobseeker
    end

    def authenticate_employer
        deny_access unless signed_in_employer?
    end

    def authenticate
        deny_access unless signed_in_jobseeker?
    end

    def deny_access
        store_location
        redirect_to sign_in_path, :notice => "Please sign in to access this page."
    end

    private

    def jobseeker_from_remember_token
        Jobseeker.authenticate_with_salt(*jobseeker_remember_token)
    end

    def employer_from_remember_token
        Employer.authenticate_with_salt(*employer_remember_token)
    end

    def employer_remember_token
        cookies.signed[:employer_remember_token] || [nil, nil]
    end

    def jobseeker_remember_token
        cookies.signed[:jobseeker_remember_token] || [nil,nil]
    end

    def store_location
        session[:return_to] = request.fullpath
    end
    
end
