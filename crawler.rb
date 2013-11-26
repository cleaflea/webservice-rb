require 'nokogiri'
require 'open-uri'
require 'rchardet19'
require 'mysql'

class Crawler
    def initialize(card_num, term)
		@url = "http://xk.urp.seu.edu.cn/jw_service/service/stuCurriculum.action?queryStudentId=#{card_num}&queryAcademicYear=#{term}"
		@connection = Mysql.new 'localhost', 'root', '', 'crawler'
		@connection.query "SET NAMES utf8"
    	@userinfo = {}
    	@courseinfo = {}
    	puts @url
    	puts 'initialize!!!'
    end
    
    def crawlsite
    	@html = Nokogiri::HTML(open(@url).read)
    end

    def getStudentInfo
    	@userinfo['department'] = @html.css("td[align='left']")[0].text.split(']')[1]
    	@userinfo['specialty'] = @html.css("td[align='left']")[1].text.split(']')[1]
    	@userinfo['studentid'] = @html.css("td[align='left']")[2].text.split(':')[1]
    	@userinfo['cardnum'] = @html.css("td[align='left']")[3].text.split(':')[1]
    	@userinfo['studentname'] = @html.css("td[align='left']")[4].text.split(':')[1]
        @userinfo.each do |key, value|
            puts 'key->' + key.to_s + 'value->' + value.to_s
        end
    end

    def getCourseInfo
        puts @html.css('table.tableline')[0].css('td')[1].text.length
    end
end

