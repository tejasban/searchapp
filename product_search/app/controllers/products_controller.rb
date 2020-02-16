class ProductsController < ApplicationController
  def index
    @search = params["search"]
    if @search.present?
      filter
      @products = @result.results
    else
      @products=Product.paginate(:page => params[:page], :per_page => 10)
    end
  end

  private
  def filter
    @result=Product.search do
      fulltext params["search"]["search"]
      if params["search"]["country"].present?
        with(:country).equal_to(params["search"]["country"])
      end
      if params["search"]["filter_price"].present?
        if params["search"]["operator"] == "="
          with(:price).equal_to(params["search"]["filter_price"])
        elsif  params["search"]["operator"] == "<"
          with(:price).less_than params["search"]["filter_price"]
        else
          with(:price).greater_than params["search"]["filter_price"]
        end
      end
      case params["search"]["sort"]
      when 'Newest'
        order_by(:created_at,:asc)
      when 'Relevance'
        order_by(:created_at,:desc)
      when 'Lowest Price'
        order_by(:price,:asc)
      when 'Highest Price'
        order_by(:price,:desc)
      end
      paginate :page => params[:page], :per_page => 10
    end
    @result
  end
end
