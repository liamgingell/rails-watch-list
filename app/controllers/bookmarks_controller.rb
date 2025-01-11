class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create, :destroy]

  def index
    @bookmarks = Bookmark.all
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = List.find(params[:bookmark][:list_id])
    @bookmark.movie = Movie.find_or_create_by(title: params[:bookmark][:movie_title]) do |movie|
      movie.overview = "Default overview" # You might want to handle this differently
    end

    if @bookmark.save
      redirect_to list_path(@bookmark.list), notice: 'Bookmark was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), notice: 'Bookmark was successfully deleted.'
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :rating, :list_id)
  end
end
