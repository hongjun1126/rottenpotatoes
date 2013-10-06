class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    @movies = Movie.find(:all, :order => 'title') if params['sort'] == 'title'
    @movies = Movie.find(:all, :order => 'release_date') if params['sort'] == 'date'
    @sort = params[:sort] if params[:sort] == 'title' || params[:sort] == 'date'
    @all_ratings = Movie.filter_rating
    @check = Movie.check_bool
    filtered_movie = []
    if(params[:ratings] != nil)
      Movie.check_bool.each{|key, value| Movie.check_bool[key] = false}

      @movies.each do |movie|
        params[:ratings].keys.each{|key| Movie.check_bool[key] = true}
        filtered_movie.push(movie) if params[:ratings].keys.include?(movie.rating)
      end
      @movies = filtered_movie
      @check = Movie.check_bool
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
