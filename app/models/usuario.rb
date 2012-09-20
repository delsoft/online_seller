class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :rememberable,
  devise :database_authenticatable, :registerable,
         :recoverable,  :trackable, :validatable,
         :confirmable, :lockable, :token_authenticatable, :timeoutable 
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
