class SearcherController < ApplicationController
  def searchq

  	model = params[:model].classify.constantize
  	table = params[:model]

  	qrystr = ""
  	
  	model.column_names.each do |clm|

  		qrystr = qrystr +  "#{clm.to_s} LIKE '%#{params[:qry]}%' OR "
  	end

  	qrystr = qrystr + "0"


  	instance_variable_set("@"+table, model.where(qrystr))

	data = render_to_string template: table+"/index",  layout: false

	render :text => data

  end
end
