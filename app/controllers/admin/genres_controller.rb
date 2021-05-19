class Admin::GenresController < ApplicationController
  def index
     @genres = Genre.all
     @genre = Genre.new
  end
    
  def edit
      @genre = Genre.find(params[:id])
  end
    
  def create
      @genre = Genre.new(genre_params)
      @genre.save
      redirect_to request.referer
  end
      
  def update
       @genre = Genre.find(params[:id])
    if @genre.update(genres_params)
       redirect_to admin_genres_path(@genre.id)
    else
       render "edit"
    end
  end 
      
  private
      
  def genre_params
    params.permit(:name)
  end
 
  def genres_params
    params.require(:genre).p ermit(:name)
  end
     
end
