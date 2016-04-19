class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :trips

  def last_ten_trips(email, password)
    UserScraper.new.get_trip_info(email, password) do |t|
      t
    end
  end

   

end
