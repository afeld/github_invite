class User < ActiveRecord::Base
  has_many :invites
end
