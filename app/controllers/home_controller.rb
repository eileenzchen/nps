class HomeController < ApplicationController
  include ApiHelper

  def home 
  end

  def contact
  end

  def about
  end

  def search
    @query = params[:query]
    if @query != ''
      @alerts = keyword_query("/alerts?q=#{@query}&")
      @articles = keyword_query("/articles?q=#{@query}&")
      @parks = keyword_query("/parks?q=#{@query}&")
      @total_hits = @alerts["total"].to_i + @articles["total"].to_i + @parks["total"].to_i
    else
      redirect_to request.referrer
    end
  end

  def state_query(state)
    @parks = '/parks?state=#{state}'
  end

end
