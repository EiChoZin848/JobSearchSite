# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_JobSearchSite_session',
  :secret      => '9d9946f7ff49a2bded7af096a40c38f84b64b5cbc44b0db0ec8626cccbe4b5449cd32a035253c76e87781920778eece11d992908fd60b6eccf2d23053abfc1a6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
