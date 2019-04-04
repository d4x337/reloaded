require "rubygems"
require "selenium/client"
require "test/unit"
require 'faker'
require 'selenium-webdriver'

class SignupTortuga < Test::Unit::TestCase
  
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
       @browser = Selenium::WebDriver.for :firefox
       @browser.get "https://reloaded.online/signin"
       @browser.manage.timeouts.implicit_wait = 3

       @firstname = Faker::Name.first_name
       @lastname  = Faker::Name.last_name
       @nick      = Faker::Internet.user_name
       @email     =  Faker::Internet.free_email
       @password  = "Andiam0.Gente"

       @browser.execute_script("document.getElementById('user_firstname').setAttribute('value', '"+@firstname+' '+@lastname+"')");
       @browser.execute_script("document.getElementById('user_email').setAttribute('value', '"+@email+"')");
       @browser.execute_script("document.getElementById('user_nickname').setAttribute('value', '"+@nick+"')");
       @browser.execute_script("document.getElementById('user_password').setAttribute('value', '"+@password+"')")
       @terms = @browser.find_element(:name, "agreement")
       @terms.click

       puts "Full Name: "+@firstname+" "+@lastname
       puts "Email    : "+@email
       puts "Nick     : "+@nick

       @submit = @browser.find_element(:id, "signup-submit")
       @submit.click

       @browser.manage.timeouts.page_load = 5

       @browser.quit

  end


  def test_signup

  end

end
