class Movie < ActiveRecord::Base

  def self.sort_by_header(header)
    if header == "title"
      Movie.order("title").all
    elsif header == "release_date"
        Movie.order("release_date").all
    else
      Movie.all
    end
  end

  def self.get_all_ratings
    Movie.find_all_ratings
  end
end
