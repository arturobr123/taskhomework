class SearchController < ApplicationController

	def search_homeworks

    query = ""

    if(params[:tipo].present?)
      queryTemp = "tipo = #{params[:tipo]} AND "
      query = query + queryTemp
    end

    if(params[:minPrice].present?)
      queryTemp = "homeworks.minPrice <= #{params[:minPrice]} AND "
      query = query + queryTemp
    end

    if(params[:maxPrice].present?)
      queryTemp = "homeworks.maxPrice >= #{params[:maxPrice]} AND "
      query = query + queryTemp
    end

    query = query + "status = ?"

    @homeworks = Homework.where(query, 1)

    @how_many_homeworks = @homeworks.count 

    respond_to do |format|
      format.html{redirect_to root_path}
      format.json {render json: @usuarios}
      format.js
    end
    
  end

end
