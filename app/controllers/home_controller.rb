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
    @parks = keyword_query('/parks?state=#{state}&')
  end

  def designation_query(designation)
    @parks = keyword_query("/parks?&")
    @parks = @parks["data"].select(|park| park["designation"] == designation)
  end

end
