class Trip < ActiveRecord::Base
  attr_accessor :start_loc, :end_loc, :start_time, :end_time, :duration, :user_id
  attr_reader :start_loc, :end_loc, :start_time, :end_time, :duration, :user_id
  TRIPS = []

  def initialize(attributes)
    attributes.each do |k, v|
      self.send(("#{k}="), v)
    end
  end

  def self.create_from_collection(collection, id)
    collection.each do |ride|
      @trip = Trip.new(ride)
      @trip.user_id = id
      @trip.save
    end
  end

  def assign_values(attributes)
    attributes.each do |attributes_hash|
      attributes_hash.each do |k,v|
        self.send(("#{k}="), v)
      end
    end
  end

end
