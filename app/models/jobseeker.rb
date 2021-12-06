class Jobseeker < ActiveRecord::Base
    #include ActiveModel::ForbiddenAttributesProtection
    attr_accessor :password, :jobseeker_remember_token,:current_jobseeker_password, :password_reset_token
    attr_accessible :name, :email, :password, :password_confirmation, :phone, :category, :skills, :about, :location, :profile

    before_save :encrypt_password
    before_save :downcase_email

    #has_many :t_skills
    has_many :t_categories
    has_many :t_appliedjobs
    mount_uploader :profile, ProfileUploader

    validates_presence_of :name, :email
    validates_length_of :name, :maximum => 30
    validates_length_of :email, :maximum => 50
    validates_length_of :phone, :maximum => 20, :on => :update
    
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates_format_of :email, :with => email_regex
    validates_uniqueness_of :email, :case_sensitive => false

    validates_confirmation_of :password
    validates_length_of :password, :within => 6..20



    #Validate current_password when the jobseeker is updated
    #validate :current_password_is_correct, :on => :update_password
    #def current_password_is_correct
    #    if !password.blank?
    #       jobseeker = Jobseeker.find_by_id(id)
    #        if(jobseeker.authenticate(current_jobseeker_password)==false)
    #            errors.add(:current_jobseeker_password, "is incorrect.")
    #        end
    #    end
    #end
    
    def has_password?(submitted_password)
        # Compare encrypted_password with the encrypted version of  submitted_password.
        encrypted_password == encrypt(submitted_password)
    end

    def self.authenticate(email, submitted_password)
        jobseeker = find_by_email(email)
        return nil if jobseeker.nil?
        return jobseeker if jobseeker.has_password?(submitted_password)
    end

    def self.authenticate_with_salt(id, cookie_salt)
        jobseeker = find_by_id(id)
        (jobseeker && jobseeker.salt == cookie_salt) ? jobseeker : nil
    end
    
    #class << self
    #   def search(query)
    #        rel = order("id")
    #       if query.present?
    #            rel = rel.where("Column name LIKE?", "%#{query}%")
    #        end
    #        rel
    #    end
    #end

    #def search(category)
    #    if category
    #        category_type = Jobseeker.find_by_category(category)
    #        if category_type
    #            self.find_by_id(category_type)
    #        else 
    #            @jobseekers = Jobseeker.all
    #        end
    #    else
    #        @jobseekers = Jobseeker.all
    #    end
    #end
    
    def create_password_reset_tokens
        self.password_reset_token = Jobseeker.new_token 
        update_attributes(:password_reset_token, Jobseeker.digest(password_reset_token))
    end

    def send_password_reset_tokens_email
        JobseekerMailer.password_reset_token(self).deliver_now
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
