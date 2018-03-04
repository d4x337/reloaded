require "rubygems"
require "selenium/client"
require "test/unit"
require 'faker'       

class SignupSpec < Test::Unit::TestCase
  
  GENDERS   = %w[Male Female]
  SESSO     = %w[Uomo Donna]

  COUNTRIES = %w[Argentina Bahamas Brazil Burundi China Colombia Cuba Egypt Finland France Germany India Indonesia Israel Italy Japan Liechtenstein Malaysia Maldives Malta Mexico               
                  Morocco Netherlands Nigeria Portugal Romania Sweden Switzerland Thailand Venezuela]                  
  DAYS      = %w[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30]

  MESI      = %w[Gen Feb Mar Apr Mag Giu Lug Ago Set Ott Nov Dic]
  MONTHS    = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]

  YEARS     = %w[1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1995 1994 1993 1992 1991 1990 1996 1997]
  
  BROWSERS  = %w[*firefox *googlechrome *safari *iexplore *opera]
  
  LOCALES   = %w[/home?locale=it /home?locale=en]
  
  def setup
 #   @verification_errors = []
 #   if $selenium
 #     @selenium = $selenium
 #   else
       @selenium = Selenium::Client::Driver.new \
          :host => "localhost",
          :port => 4444,
          :browser => "*firefox",
          :url => "https://www.tortuga.tech",
          :timeout_in_second => 60
      @selenium.start
  #  end
    
    @selenium.set_context("test_signup")
  
  end

  def teardown
    @selenium.stop 
  end

  def test_signup
      @lang = LOCALES.sample
      puts "Pointing2: "+@lang
        
      if @lang == "/index?locale=it"
        @choosen_lang = "IT"
      elsif @lang == "/index?locale=en"
        @choosen_lang = "EN"  
      end
      puts "Language : "+@choosen_lang

      @browser = Selenium::Client::Driver.new(:host=>"localhost",:port=>4444,:browser_url=>"http://www.tortuga.tech")



      @browser = Selenium::Client::Driver.new \
          :host => "localhost",
          :port => 4444,
          :browser => "*firefox",
          :url => "http://www.tortuga.tech",
          :timeout_in_second => 60

        @browser.start

        if @choosen_lang == "IT"
          @browser.open "/index?locale=it"
        elsif @choosen_lang == "EN"  
          @browser.open "/index?locale=en"
        end

        @browser.wait_for_page_to_load "600000"
        
        @firstname = Faker::Name.first_name
        @browser.type "id=user_firstname", @firstname
        puts "Firstname: "+@firstname
        
        @lastname = Faker::Name.last_name
        @browser.type "id=user_lastname", @lastname
        puts "Lastname : "+@lastname
        
        @nick = Faker::Internet.user_name

        @browser.type "id=user_nickname", @nick
        puts "Nick     : "+@nick
       
        @email =  Faker::Internet.free_email
        @browser.type "id=user_email", @email
        puts "Email    : "+@email
        
        @browser.type "id=user_password", "Pl0kta.13"
        @browser.type "id=user_password_confirmation", "Pl0kta.13"
        
        if @choosen_lang == "IT"
           @sex = SESSO.sample
        elsif @choosen_lang == "EN"
           @sex = GENDERS.sample
        end
        @browser.select "id=user_gender",  "label="+@sex
        puts "Gender   : "+@sex
         
        @country = COUNTRIES.sample
        @browser.select "id=user_country", "label="+@country
        puts "Country  : "+@country
        
        @day = DAYS.sample
        @browser.select "id=user_birthday_3i", "label="+@day
        
        @month =""
        if @choosen_lang == "IT"
          @month = MESI.sample
        elsif @choosen_lang == "EN"
          @month = MONTHS.sample
        end
         @browser.select "id=user_birthday_2i", "label="+@month
        
        @year = YEARS.sample
        @browser.select "id=user_birthday_1i", "label="+@year
        
        puts "Birthday : "+@day+" "+@month+" "+@year
        
        @browser.click "id=agreement"
        
        @browser.click "id=signup-submit", :wait_for => :page
       
   #     if @choosen_lang == "IT"
    #      assert @browser.text?("messaggio con un link di conferma è stato")
     #   elsif @choosen_lang == "EN"
      #    assert @browser.text?("message has been sent")
       # end
        @browser.stop
  end

end