module StatusesHelper
  def get_current_status(user_id)
    @user=User.find(user_id)
    @status = Status.where(:user_id=>user_id,:current=>true).order(:set_at).reverse_order.limit(1)
    if @status.present?
      return @status.first.status
    else
      return "Hey There! I'm using Reloaded"
    end    
  end
  
  
  
  def last_status_set(user_id)
    @user=User.find(user_id)
    @status = Status.where(:user_id=>user_id,:current=>true).order(:set_at).reverse_order.limit(1)
    if @status.first.present?
      if not @status.first.set_at.blank?
        return @status.first.set_at
      else
        return ""
      end 
    else
      return ""
    end    
  end
  
  def has_one_status?(user_id)
    @user=User.find(user_id)
    @status = Status.where(:user_id=>user_id,:current=>true).order(:set_at).reverse_order.limit(1)
    if @status
      return true
    else
      return false
    end 
  end
  
  def has_set_at_status?(user_id)
    @user=User.find(user_id)
    @status = Status.where(:user_id=>user_id,:current=>true).order(:set_at).reverse_order.limit(1)
    @status = @status.first
    if @status.present?
      if @status.set_at != nil
        return true
      else
        return false
      end
    else
      return false
    end
     
  end
  
end
