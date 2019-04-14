class Feedback < ActiveRecord::Base
  
  attr_accessible :from,:email,:reason,:message,:rating,:ip,:country,:sent_at,:deleted

  after_create :send_feedback
  TYPES = %w[bug feedback translation help abuse]

   # validates :from ,:presence => true, :length => { :in => 3..100 },:format => { :with => /\A[a-zA-Z\s]+\z/, :message => "This is not a valid name"}
   # validates :email ,:presence => true, :length => { :in => 8..100 },:format => { :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i, :message => "This is not a valid address" }
   # validates :message  ,:presence => true, :length => { :in => 1..400 },:format => { :with => /\A[a-zA-Z0-9\s]+\z/, :message => "This is not a valid message"}
   # validates :reason, :presence => true, :inclusion => { :in => TYPES },:format => { :with => /\A[a-zA-Z0-9\s]+\z/, :message => "reason contains unknow chars"}
   # validates :country   ,:presence => true, :length => { :in => 2..2 } , :inclusion => { :in =>['AF','AL','DZ','AS','AD','AO','AI','AQ','AG','AR','AM','AW','AU','AT','AZ','BS','BH','BD','BB','BY','BE','BZ','BJ','BM','BT','BO','BA','BW','BV','BR','IO','BN','BG','BF','BI','KH','CM','CA','CV','KY','CF','TD','CL','CN','CX','CC','CO','KM','CG','CD','CK','CR','CI','HR','CU','CY','CZ','DK','DJ','DM','DO','TP','EC','EG','SV','GQ','ER','EE','ET','FK','FO','FJ','FI','FR','FX','GF','PF','TF','GA','GM','GE','DE','GH','GI','GR','GL','GD','GP','GU','GT','GN','GW','GY','HT','HM','VA','HN','HK','HU','IS','IN','ID','IR','IQ','IE','IL','IT','JM','JP','JO','KZ','KE','KI','KP','KR','KW','KG','LA','LV','LB','LS','LR','LY','LI','LT','LU','MO','MK','MG','MW','MY','MV','ML','MT','MH','MQ','MR','MU','YT','MX','FM','MD','MC','MN','MS','MA','MZ','MM','NA','NR','NP','NL','AN','NC','NZ','NI','NE','NG','NU','NF','MP','NO','OM','PK','PW','PA','PG','PY','PE','PH','PN','PL','PT','PR','QA','RE','RO','RU','RW','KN','LC','VC','WS','SM','ST','SA','SN','SC','SL','SG','SK','SI','SB','SO','ZA','GS','ES','LK','SH','PM','SD','SR','SJ','SZ','SE','CH','SY','TW','TJ','TZ','TH','TG','TK','TO','TT','TN','TR','TM','TC','TV','UG','UA','AE','GB','US','UM','UY','UZ','VU','VE','VN','VG','VI','WF','EH','YE','YU','ZM','ZW']}

  def send_feedback
    UserMailer.send_feedback(self.id).deliver
  end

end
