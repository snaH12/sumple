class Admin::ItemsController < ApplicationController
  
  def index
    #ページネーションの使用
    @item = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(admin_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: "You have created item successfully."
    else
      render :new
　   end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    #特定のアイテムをidで検す
      @item = Item.find(params[:id])
    if @item.update(admin_params)
        redirect_to admin_item_path(@item), notice: "You have updated item successfully."
    else
        render :edit
    end
  end
  
private

  def admin_params
    params.require(:item).permit(:name, :introduction, :genre, :price, :is_active, :image, :genre_id)
  end
end
