class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    
    
    if params[:q]&.values&.present?
      @q = Book.ransack(params[:q])
      @result = @q.result(distinct: true)
      @word = params[:q].values.first
    else 
      @result = Book.tagged_with(params[:tag])
      @word = params[:tag]
    end

    # if @range == "User"
    #   @users = User.looks(@search, @word)
    # elsif @range == "Book"
    #   @books = Book.looks(@search, @word)
    # else
    #   
    # end
    render :search_result
  end
end
