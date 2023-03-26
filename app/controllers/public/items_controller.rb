class Public::ItemsController < ApplicationController
  
  def index
    #ジャンルが存在するなら
    if params[:genre_id].present?
      #Itemモデルのスコープ（search_genre）処理　（引数特定のジャンルid）
      @items = Item.search_genre(params[:genre_id]).page(params[:page]).per(8)
      @title = params[:genre_name]
      @add_items_title = @items.first.name if @items.present?
    else
      @items = Item.page(params[:page]).per(8)
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart = CartItem.new
  end
  
end
