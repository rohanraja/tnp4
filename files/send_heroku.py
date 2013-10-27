import mechanize
import urllib2
response = urllib2.urlopen('http://tp.iitkgp.ernet.in/notice/notice.php?sr_no=10488')
html = response.read()

#print html.strip('\n').rstrip()


br = mechanize.Browser()

br.open('http://iitkgptnp.herokuapp.com/links/new')

br.select_form(nr=0)

br.form["link[pageno]"] = "2312"

br.form["link[date]"] = "2013-10-23 18:54"
br.form["link[html]"] = html 

br.form["link[title]"] = "From Python on Mac 22"
br.form["link[date_added]"] = "2013-10-23 18:54"


br.submit()