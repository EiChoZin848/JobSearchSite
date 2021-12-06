class Employer < ActiveRecord::Base
    attr_accessor :password, :employer_remember_token ,:password_reset_token, :current_employer_password
    attr_accessible :name, :email, :phone, :address, :info, :location, :profile, :password, :password_confirmation
    before_save :downcase_email
    before_save :encrypt_password

    # For Password change 
    #has_secure_password

    has_many :t_joboffers, :dependent => :destroy
    
    mount_uploader :profile, ProfileUploader
    
    validates_presence_of :name, :email
    validates_length_of :name, :maximum => 30
    validates_length_of :email, :maximum => 50
    validates_length_of :phone, :maximum=> 20

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates_format_of :email, :with => email_regex
    validates_uniqueness_of :email, :case_sensitive => false
    validates_length_of :password, :within => 6..20
    
    #validates_password_match_of :current_employer_password, :on => :update, :if => :password
    validates_confirmation_of :password
    


    def has_password?(submitted_password)
        # Compare encrypted_password with the encrypted version of  submitted_password.
        encrypted_password == encrypt(submitted_password)
    end

    def self.authenticate(email, submitted_password)
        employer = find_by_email(email)
        return nil if employer.nil?
        return employer if employer.has_password?(submitted_password)
    end
    
    def self.authenticate_with_salt(id, cookie_salt)
        employer = find_by_id(id)
        (employer && employer.salt == cookie_salt) ? employer : nil
    end



    def create_password_reset_tokens
        self.password_reset_token = Employer.new_token 
        update_attributes(:password_reset_token, Employer.digest(password_reset_token))
    end

    def send_password_reset_tokens_email
        EmployerMailer.password_reset_token(self).deliver_now
    end
    
    private
        def downcase_email
            self.email = email.downcase
        end

        def encrypt_password
            self.salt = make_salt if new_record?
            self.encrypted_password = encrypt(password)
        end

        def encrypt(string)
            secure_hash("#{salt}--#{string}") # Only a temporary implementation!
        end

        def make_salt
            secure_hash("#{Time.now.utc}--#{password}")
        end

        def secure_hash(string)
            Digest::SHA2.hexdigest(string)
        end
end
