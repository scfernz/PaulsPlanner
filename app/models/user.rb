class User < ActiveRecord::Base
  validates :name, presence: true
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }, :default_url => 'default-profile.png'
  validates_attachment :image,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..10.megabytes }
  rolify
  after_create :assign_role
  belongs_to :cohorts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  has_and_belongs_to_many :meetings
  has_many :tasks

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
    end
  end

  def assign_role
    if self.provider.nil?
      add_role(:provisional)
    else
      add_role(:student)
    end
  end
end
