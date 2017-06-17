class User < ApplicationRecord
	attr_accessor :remember_token 
	validates :email, presence: true
	validates :username, presence: true
	before_create :create_remember_digest
	has_secure_password


	def create_remember_digest
		self.remember_token = User.new_token
		self.remember_digest = User.digest(remember_token)
	end

	def self.new_token
		SecureRandom.urlsafe_base64
	end

	def self.digest(token)
		Digest::SHA1.hexdigest token
	end
end
