class Admin::GenresController < ApplicationController
  
  
  def index
     @genres = Genre.all
     @genre = Genre.new
  end
    
  def edit
      @genre = Genre.find(params[:id])
  end
    
  def create
       @genre = Genre.new(genres_params)
     if @genre.save
        redirect_to request.referer
        flash[:notice] = '作成しました'
     else
        @genres = Genre.all
        render 'index'
     end
  end
      
  def update
       @genre = Genre.find(params[:id])
    if @genre.update(genres_params)
       redirect_to admin_genres_path(@genre.id)
       flash[:notice] = '更新しました'
    else
       render "edit"
    end
  end 
      
  private
      

  def genres_params
    params.require(:genre).permit(:name)
  end
     
end
