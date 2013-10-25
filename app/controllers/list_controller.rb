class ListController < ApplicationController


  before_filter :authenticate, :only => [:updatedata]


  def index

  	#l = Link.find(3)
  	#data = l.html
  	@data = "SELECT"#data.gsub(/Training & Placement Section - IIT Kharagpur/, '')
  	@links = Link.find(:all, :order => "date_added desc", :limit => 10)
  end

  def getdata
  	require 'open-uri'
  	

	for i in 1..5

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


  def updatedata
  	require 'open-uri'
    require 'rubygems'
    require 'mechanize'
    agent = Mechanize.new



  	encoding_options = {
    :invalid           => :replace,  # Replace invalid byte sequences
    :undef             => :replace,  # Replace anything not defined in ASCII
    :replace           => "'",        # Use a blank for those replacements
    :universal_newline => true       # Always break lines with \n
  }
  
  	for i in 201..600

	  	url = "http://tp.iitkgp.ernet.in/notice/index.php?page=#{i}"

			  open(url, 'rb') do |read_file|
			  	
			  	data = read_file.read

			  

	  		
	  		doc = Nokogiri::HTML(data)

	  		dates = doc.css("td[width='25%']")
	  		links = doc.css("td[width='70%']")
	  		lnks = links.css("a")
	  		#render :text => doc.css("td")[10]['width']
	  		str = ""
	  		to_update = true
	  		l = Link.order("date_added DESC").first

	  		if l == nil
	  			l = Link.new()
	  			l.date_added = "1900-10-01 00:00".to_datetime
	  		end

	  		for i in 0..dates.length-1

	  			pageno = lnks[i]['href'].partition('=').last
	  			#str += pageno + " " +  dates[i] + "<br>"

	  			url = "http://tp.iitkgp.ernet.in/notice/notice.php?sr_no=#{pageno}"
	  			open(url, 'rb') do |read_file|
				  	data = read_file.read

				  	doc2 = Nokogiri::HTML(data)
				  	curdate = doc2.css("td[align='right'] b")

				  	str = ""

				  	if l.date_added == curdate.text.to_datetime
				  		to_update = false
				  		redirect_to root_url
				  		return
				  	else
				  		to_update = true
				  	end


				  	data = data.encode Encoding.find('ASCII'), encoding_options
				  	title =  lnks[i].text
				  	title = title.encode Encoding.find('ASCII'), encoding_options

            # agent.get("http://iitkgptnp.herokuapp.com/links/new")

            # agent.page.forms[0]["link[pageno]"] = pageno
            # agent.page.forms[0]["link[date]"] = curdate.text
            # agent.page.forms[0]["link[html]"] = data
            # agent.page.forms[0]["link[date_added]"] = curdate.text.to_datetime
            # agent.page.forms[0]["link[title]"] = title
  
            #  agent.page.forms[0].submit

				    d = Link.new(:title => title ,:pageno => pageno, :date => curdate.text , :html => data,  :date_added => curdate.text.to_datetime)
				    d.save
			 	end

	  			
	  		end
	  		#render :text => str#lnks[0]['href'] + " " +  dates[0]

	  		

	  	end

  	
  	end
  	


  	redirect_to root_url
  end


  def send_desc

  #	render :text => params[:link_id]

  	id = params[:link_id]

  	l = Link.find(id)

  	data = l.html
  	@data = data.gsub(/Training & Placement Section - IIT Kharagpur/, '')

    word = []

    

  	if params[:qry]
  		@qry = params[:qry]
      word.concat(@data.scan(/#{@qry}/i))

      words = @qry.split(' ')

      words.each do |s|
        if s.length > 1
          word.concat(@data.scan(/#{s}/i))
        end
      end

  	else
  		@qry = "zzzz"
      word[0] = "zzz"
  	end

    if @qry == "zzzzz"
      word[0] = "zzz"
    end
  	
  	word.each do |w|

      @data = @data.gsub(/#{w}/, '<mark>' + w + '</mark>')

    end

    respond_to do |format|

       
        format.js {  }
       
      
    end

  end


  def searchq

  	qry = params[:qry]

    words = qry.split(' ')

    qrystr = "html ILIKE '%#{words[0]}%'"

    words.each do |s|

      if s.length > 1

        qrystr += " AND html ILIKE '%#{s}%'" 
      end

    end

  	#links = Link.where("html ILIKE '%#{qry}%'").take(80)
    links = Link.order("date_added DESC").where(qrystr).take(80)

    if qry == "0"
      links = Link.find(:all, :order => "date_added desc", :limit => 10)
      qry = 'zzzzz'
    end  

  	@q = qry

    # links.each do |l|

    #   cnt = 0

    #   words.each do |s|
    #    # puts "**&&**&&" + s

    #     if l.html.scan(/#{s}/i).count > 0

    #       cnt = cnt + l.html.scan(/#{s}/i).count

    #     end

    #   end

    #   puts cnt.to_s
    # end

  	render links 

  	#render :text => links.first.html

  end

helper_method :logged_in?

def logged_in?
  session[:login]
end

def do_logout
  session[:login] = nil
end

def authenticate
  login = authenticate_or_request_with_http_basic do |username, password|
    username == "rohan1020" && password == "rohan93"
  end
  session[:login] = login
end



end
