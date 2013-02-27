class MoviesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_all_ratings
    @redirect = false

    if params.has_key?(:header)
      session[:header] = params[:header]
      @header = params[:header]
      @movies = Movie.order(@header)
    elsif session.has_key?(:header)
      @redirect = true
      params.update({:header=>session[:header]})
      #@header = session[:header]
      #@movies = Movie.order(@header)
    else
      @movies = Movie.all
    end

    if params.has_key?(:ratings)
      session[:ratings] = params[:ratings]
      @checked_ratings = params[:ratings].keys
    elsif session.has_key?(:ratings)
      @redirect = true
      params.update({:ratings=>session[:ratings]})
    else
      @checked_ratings = @all_ratings
    end

    if @redirect
      flash.keep
      redirect_to :action=>:index, :ratings=>params[:ratings], :header=>params[:header]
    else
      @movies = @movies.where(:rating => @checked_ratings).all
    end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
