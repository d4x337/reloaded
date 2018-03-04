class Ability  
  
  #Permissions regarding authenticated users only. 
  include CanCan::Ability  

  def initialize(user)  
    user ||= User.new  
    
    done = false
    
    can :manage, User
    can :manage, Status
    can :manage, UserContact
    can :manage, Contact
    can :manage, Message
    can :manage, Invitation
    can :manage, Request
    can :manage, Picture
    can :manage, Update
    can :manage, Product
    can :manage, Cart
    can :manage, Order

    

    if user.role? :master
        can :manage, :all
        can :read, :all
    end
    
    if user.role? :admin
        can :manage, :all
        can :read, :all
    end
    
    if user.role? :cpr
        can :manage, Invitation
        can :manage, Request
        can :read, Income
    end
  
    if user.role? :pr
        can :manage, Invitation
        can :manage, Request
        can :read, Income
    end
    
    if user.role? :prj
        can :manage, Invitation
        can :read, Income
    end
    
  end  
end  


### MODEL - CAN CREATE - CAN UPDATE - CAN DESTROY #######
### TO DO - CREATE MATRIX ROLES*PERMISSIONS ABOVE AND 
### ASSIGN AUTHORIZATIONS - d4x #########################
