class Link < ActiveRecord::Base


	serialize :things

  validates :pageno, uniqueness: true
  validates :title, presence: true


@@ololo = 1

  # instance level

  # getter
  def self.get_olo
    @@ololo
  end
  # setter
  def self.set_olo(trololo)
    @@ololo = trololo
  end


  def get_olo
  	@@ololo

  end


  def save_array(the_array)

  	yaml_str = the_array.to_yaml

  	arr = YAML.load(yaml_str)
    arr


  end

  def self.fetchAndParse

  	require 'open-uri'

  	encoding_options = {
    :invalid           => :replace,  # Replace invalid byte sequences
    :undef             => :replace,  # Replace anything not defined in ASCII
    :replace           => "'",        # Use a blank for those replacements
    :universal_newline => true       # Always break lines with \n
  }
    for i in 400..14700
      
      pageno = i
      
      url = "http://tp.iitkgp.ernet.in/notice/notice.php?sr_no=#{pageno}"

      open(url, 'rb') do |read_file|
        data = read_file.read

        doc2 = Nokogiri::HTML(data)
        curdate = doc2.css("td[align='right'] b")
        title = doc2.css("td[align='right']")[0].previous_sibling.css("b")

        data = data.encode Encoding.find('ASCII'), encoding_options
        title = title.text.encode Encoding.find('ASCII'), encoding_options
        puts title

        d = Link.new(:title => title ,:pageno => pageno, :date => curdate.text , :html => data,  :date_added => curdate.text.to_datetime)
        d.save
      end
    end
  end


end
