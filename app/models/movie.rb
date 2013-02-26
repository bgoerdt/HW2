class Movie < ActiveRecord::Base
  def sort_by_header(header)
    if header == "title"
      Movie.order("title").all
    elsif header == "release_date"
        Movie.order("release_date").all
    else
      Movie.all
    end
  end
end
