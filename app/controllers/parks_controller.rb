class ParksController < ApplicationController

  def show
    @park_code = params[:park_code]
    
  end

end
