class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  require "open-uri"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :first_name, :last_name, :profile_name
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true, uniqueness: true, format: {
    with: /\A[a-zA-Z\-\_]+\Z/,
    message: 'must be letters or numbers.'
  }
  has_attached_file :avatar, :styles => {
    :large => "800x800>", :medium => "300x200>", :small => "260x180>", :thumb => "80x80#"
  }
  validates_attachment_content_type :avatar, :content_type => /^image\/(bmp|gif|jpg|jpeg|png)/
  
  has_many :activities
  has_many :albums
  has_many :pictures
  has_many :statuses
  has_many :user_friendships
  has_many :friends, -> { where(user_friendships: { state: "accepted"}) }, through: :user_friendships

 has_many :pending_friends, 
              -> { where user_friendships: { state: "pending" } }, 
                 through: :user_friendships,
                 source: :friend
 has_many :requested_user_friends, 
              -> { where user_friendships: { state: "requested" } }, 
                 through: :user_friendships,
                 source: :friend
 has_many :blocked_user_friends, 
              -> { where user_friendships: { state: "blocked" } }, 
                 through: :user_friendships,
                 source: :friend

  def self.get_gravatars
    all.each do |user|
      if !user.avatar?
        user.avatar = URI.parse(user.gravatar_url)
        user.save
      end
    end
  end

  def full_name
  	first_name + ' ' + last_name
  end

def gravatar_url
  stripped_email = email.strip
  downcased_email = stripped_email.downcase
  hash = Digest::MD5.hexdigest(downcased_email)

  "http://gravatar.com/avatar/#{hash}"
end
def to_param
    profile_name
  end
 def to_s
    first_name
end

def has_blocked?(other_user)
  blocked_friends.include?(other_user)
end

def create_activity(item, action)
  activity = activities.new
  activity.targetable = item
  activity.action = action
  activity.save
end 
end
