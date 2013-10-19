class ListController < ApplicationController
  def index

  end

  def getdata
  	require 'open-uri'
  	

	for i in 1..100

		fname = "files/page#{i}.html"

#		File.open(fname, "wb") do |saved_file|

		  url = "http://tp.iitkgp.ernet.in/notice/index.php?page=#{i}"

		  open(url, 'rb') do |read_file|
		  	data = read_file.read
		   # saved_file.write(data)
		    d = Datapage.new(:url => url , :html => data)
		    d.save
		  end



		
	end

  end


  def parsedata
  	require 'open-uri'

  	Datapage.all.each do |f|

  		data = f.html
  		doc = Nokogiri::HTML(data)

  		dates = doc.css("td[width='25%']")
  		links = doc.css("td[width='70%']")
  		lnks = links.css("a")
  		#render :text => doc.css("td")[10]['width']
  		str = ""
  		for i in 0..dates.length-1
  			pageno = lnks[i]['href'].partition('=').last
  			#str += pageno + " " +  dates[i] + "<br>"

  			url = "http://tp.iitkgp.ernet.in/notice/notice.php?sr_no=#{pageno}"
  			open(url, 'rb') do |read_file|
			  	data = read_file.read

			  	doc2 = Nokogiri::HTML(data)
			  	curdate = doc2.css("td[align='right'] b")

			    d = Link.new(:pageno => pageno, :date => curdate.text , :html => data, :date_added => curdate.text.to_datetime)
			    d.save
		 	end

  			
  		end
  		#render :text => str#lnks[0]['href'] + " " +  dates[0]

  		

  	end

  	redirect_to links_url

  	

  end


end
