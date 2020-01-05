class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images).order('created_at DESC').limit(20)
  end

  def new
    @item = Item.new
    @item.images.new
    @item.build_shipping
    @category = Category.all.order("id ASC").limit(20)
  end

  def create
    # ブランドはstrでparamsにのってくるので、該当するbrand_idを探す
    @brand_data = Brand.find_by(name: params[:item][:brand])
    if @brand_data != nil
      @brand_id = Brand.find_by(name: params[:item][:brand]).id
    else
      @brand_id = nil
    end
    
    @item = Item.new(item_params.merge(brand_id: @brand_id))
    if @item.save
      redirect_to root_path
    else
      @category = Category.all.order("id ASC").limit(13)
      redirect_to action: 'new'
    end
  end

  def buy
  end

  def show
  end

  def edit
    @category = Category.all.order("id ASC").limit(13)
    @item = Item.find(params[:id])
    @selected_category = Category.find(@item.category_id)
    if @item.size_id != nil
      @selected_size = Size.find(@item.size_id)
      @selected_size_siblings = Size.where(classification: @selected_size.classification)
    end
    
  end

  def update
    @brand_data = Brand.find_by(name: params[:item][:brand])
    if @brand_data != nil
      @brand_id = Brand.find_by(name: params[:item][:brand]).id
    else
      @brand_id = nil
    end

    @item = Item.find(params[:id])
    if @item.update!(item_params.merge(brand_id: @brand_id))
      redirect_to action: 'index'
    else
      redirect_to action: 'edit'
    end
  end

  def category_children
    @category_children = Category.find(params[:category_value]).children
  end

  def category_grandchildren
    @category_grandchildren = Category.find(params[:category_value]).children
  end

  def set_sizes
    @set_sizes = Size.where(classification: params[:parents_category_value])
  end

  def cal_profit
    @price = params[:price].to_i
    @sales_commission = (@price * 0.1).to_i
    @profit = (@price * 0.9).to_i
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :state, :condition, :category_id, :size_id,
                                  images_attributes: [:id, :image, :_destroy], 
                                  shipping_attributes: [:method, :prefecture_from, :period_before_shopping, :fee_burden])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
