class HomeController < ApplicationController
  
  STATES = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]
  STATES_HASH = {}
  STATES.each do |full, abrev|
    STATES_HASH[abrev] = full
  end

  DESIGNATIONS = ["National Park", "National and State Parks", "National Historic Site", "National Heritage Area", "National Heritage Corridor", "National Monument", "National Memorial", "National Preserve", "National Recreation Area", "National Park & Preserve", "National Reserve", "National Military Park", "National Battlefield", "National Geologic Trail", "National Historic Trail", "National Seashore", "National Scenic Trail", "National Scenic River", "National Scenic Riverways", "National Historical Park", "National Historical Park and Ecological Preserve", "National River", "National Lakeshore", "National Wild and Scenic River & Riverway", "Part of Colonial National Historical Park", "Memorial Parkway", "Wild & Scenic River", "Scenic & Recreational River", "Wild River", "Park", "Heritage Area", "Other Designation"]
  
  include ApiHelper

  
  def home 
    @states_list = STATES
    @desig_list = DESIGNATIONS
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

  def state_search
    @state = params[:state]
    @state_fullname = STATES_HASH[@state]
    @parks = keyword_query("/parks?stateCode=#{@state}&")

  end

  def desig_search
    @designation = params[:desig]
    @designation = @designation.gsub(" ", "+")
    @parks = keyword_query("/parks?q=#{@designation}&limit=100&")
    @designation = @designation.gsub("+", " ")
    @parks = @parks["data"].select{|park| park["designation"] == @designation}
  end

  

end
