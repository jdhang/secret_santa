class ItemsController < ApplicationController
  before_action :set_item, except: [:new, :create]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    current_user.items << @item

    if @item.save
      redirect_to "/wishlist"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to "/wishlist"
    else
      render :edit
    end
  end

  def edit_row
    respond_to do |format|
      format.js {}
    end
  end

  def back_row
    respond_to do |format|
      format.js {}
    end
  end

  def edit_name
    respond_to do |format|
      format.js {}
    end
  end

  def edit_link
    respond_to do |format|
      format.js {}
    end
  end


  def destroy
    @item.destroy
    flash[:notice] = "Wishlist item was successfully deleted."
    redirect_to "/wishlist"
  end

  private
    def item_params
      params.require(:item).permit(:name, :link)
    end

    def set_item
      @item = Item.find(params[:id])
    end

end