class HomeController < ApplicationController

  def home 
  end

  def contact
  end

  def about
  end

  def search
    @query = params[:query]

    @parks = Item.search(@query)
    @customers = Customer.search(@query)
    @total_hits = @items.size + @customers.size

  end

end
