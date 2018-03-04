class Visitor < ActiveRecord::Base
  
  attr_accessible :session_id, :username, :sha, :headers, :user_agent, :remote_host, :method, :visited_url, 
  :http_accept, :query_string, :cookie_string, :login_attempt

end
