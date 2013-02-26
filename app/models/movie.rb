class Movie < ActiveRecord::Base

  def self.get_all_ratings
    ratings = Array.new
    Movie.all.each do |m| 
      if !ratings.include?("#{m.rating}")
        ratings << "#{m.rating}"
      end
    end
    return ratings
  end

end
