Reloaded::Application.routes.draw do

  use_doorkeeper

  devise_for :users, :controllers => { :registrations => "users/registrations" }
  #devise_for :users, :controllers => { :registrations => "users/registrations",:sessions => "users/sessions" }
  
 #  devise_for :users, :controllers => { :registrations => "users/registrations", 
 #   :sessions=> 'users/sessions',:invitations => 'users/invitations', 
 #   :omniauth_callbacks=>'omniauth_callbacks' },
 #   :token_authentication_key => 'authentication_key'3333333333333333333333333

  resources :user_contacts, :users, :statuses, :efiles, :search, :contacts, :options, :invitations, :chats, :blocked_users, :channels, :channel_users, :shadow,
            :messages,:products,:carts,:cart_items,:ads,:orders,:feedbacks,:cart_products,:quotes,:quote_types,:authors,:links, :uploads, :countries, :posts,:domains,:mail_accounts,:pictures,:alias_maps,:mini_post_comments, :timeline, :mini_post_comment_likings,:tags, :updates, :post_tags, :requests, :mini_post_likings, :friends, :mini_post_favorites, :blog_settings, :path_prefix => '/:locale'
  
  resources :phone_numbers, :only => [:new,:create]

  resources :charges

  resources :search do
    post 'go-to-category', :controller => 'search', :action => 'go_to_category', :method => :post
    get 'complete', :controller => 'search', :action => 'complete', :method => :get
    post 'find',:controller => 'search',:action=>'find',:method=>:post
  end
 
  resources :index do
    post 'addcoupon',:controller => 'index',:action => 'addcoupon',:method => :post
    post 'checknick',:controller => 'index',:action => 'checknick',:method => :post
    post 'checkemail',:controller =>'index',:action => 'checkemail',:method =>:post
  end

  resource :messages do

    post 'get',  :controller=>'messages', :action=>'read_message',  :method=>'get'
    post 'get',  :controller=>'messages', :action=>'reveal',  :method=>'get'
  end
  
  resource :options do
    post 'registrations_mode',  :controller=>'options', :action=>'registrations_mode',  :method=>'post'
  end

  resource :messages do
    post 'set-status',  :controller=>'statuses', :action=>'usestatus',  :method=>'post'
  end

  resource :users do
    post 'set-background',  :controller=>'users', :action=>'set_background',  :method=>'post'
  end

  resources :mini_posts do
    resources :mini_post_comments,:mini_post_tags,:mini_post_likings,:mini_post_comment_likings,:mini_post_feeds,:feeds
      get 'mini_posts',:controller => 'mini_posts',:action => 'index',:method => :get
      
      post 'like',:controller => 'mini_posts', :action => 'like', :method => :post
      post 'liked',:controller => 'mini_posts', :action => 'liked', :method => :post
      post 'liking',:controller => 'mini_posts', :action => 'liking', :method => :post
      post 'disliking',:controller => 'mini_posts', :action => 'disliking', :method => :post
      post 'favoriting',:controller => 'mini_posts', :action => 'favoriting', :method => :post
      post 'sharel',:controller => 'mini_posts', :action => 'sharel', :method => :post
      post 'sharep',:controller => 'mini_posts', :action => 'sharep', :method => :post
      post 'disklike',:controller => 'mini_posts',:action => 'dislike',:method => :post
  end
 
  resources :iposts, only: [:index, :show]
  get '/posts_with_button', to: 'iposts#index_with_button', as: 'posts_with_button'
  
  resources :wall do 
    resources :mini_post_comments,:mini_post_tags,:mini_post_likings,:mini_post_comment_likings
      get 'wall', :controller => 'wall', :action => 'index', :method => :get
      get 'likes', :controller => 'wall', :action => 'likes', :method => :get
      get 'favorites', :controller => 'wall', :action => 'favorites', :method => :get
      get 'updwall', :controller => 'wall', :action => 'indexupd', :method => :get
  end

  resources :posts do
      post 'save_settings', :controller => 'posts', :action => 'save_settings', :method => :post
      post 'idtag', :controller => 'posts', :action => 'idtag', :method => :post
  end

  resources :contacts do
    patch :crop, on: :member
  end
  
  resources :users do
    patch :crop, on: :member
	end

  resource :carts do
    post 'add-to-cart',  :controller=>'carts', :action=>'add_to_cart',  :method=>'post'
	end

  resource :orders do
    post 'express',  :controller=>'orders', :action=>'express',  :method=>'post'
    post 'confirm',  :controller=>'carts', :action=>'confirm',  :method=>'post'
    get 'notification', :controller =>'orders',:action=>'notification',:method=>'get'
    get 'success', :controller =>'orders',:action=>'success',:method=>'get'
    get 'failure', :controller =>'orders',:action=>'failure',:method=>'get'
  end

  resource :agadanga do
    post 'agadanga-send',  :controller=>'agadanga', :action=>'agadanga_send',  :method=>'post'
    post 'agadanga-save-draft', :controller=>'agadanga', :action=>'agadanga_save_draft', :method=>'post'
    post 'agadanga-discard', :controller=>'agadanga', :action=>'agadanga_discard', :method=>'post'
  end
  
  devise_scope :user do
    get 'register'         => 'devise/registrations#new' 
    get 'signup'           => 'devise/registrations#new' 
    get 'login'            => 'devise/sessions#new'    
    get 'signin'           => 'devise/sessions#new'    
    get 'logout'           => 'devise/sessions#destroy'
    get 'exit'             => 'devise/sessions#destroy'
    get 'refresh-password' => 'devise/registrations#edit' 
    get 'change-password'  => 'devise/registrations#edit'
    get 'activation'  => 'devise/registrations#activation'
    get 'coupon_activation'  => 'devise/registrations#coupon_activation'
  end
  
  authenticated :user do
    root to: 'users#home', as: :authenticated_root
  end

 # unauthenticated do
    root to: 'index#index'#, as: :unauthenticated_root
 # end
 
  namespace :api do
    namespace :v1 do
      resources :messages,:contacts,:statuses,:countries,:efiles,:statuses,:user_contacts,:invitations,:search,:uploads, :defaults => { :format => 'json' }
    end
  end

  resource :agadanga do
    post 'agadanga-send',  :controller=>'agadanga', :action=>'agadanga_send',  :method=>'post'
    post 'agadanga-save-draft', :controller=>'agadanga', :action=>'agadanga_save_draft', :method=>'post'
    post 'agadanga-discard', :controller=>'agadanga', :action=>'agadanga_discard', :method=>'post'
  end

  resource :pictures do
    post 'upload-picture',  :controller=>'pictures', :action=>'create',  :method=>'post'
  end

  resource :feedbacks do
    post 'send-feedback',  :controller=>'feedbacks', :action=>'create',  :method=>'post'
  end

  post 'registrations_mode' => 'options#registrations_mode'
  post 'addcontact'    => 'user_contacts#create'
  post 'usestatus'     => 'statuses#usestatus'
  post 'check_passphrase'   => 'messages#check_passphrase'

  post 'activation'    => 'charges#create'
  post 'coupon_activation'   => 'charges#create'

  post 'set-background'       => 'users#set_background'
  post 'set-status'           => 'statuses#usestatus'

  get 'hashtags/:hashtag',   to: 'hashtags#show',      as: :hashtag
  get 'hashtags',            to: 'hashtags#index',     as: :hashtags


  get 'revealed'       => 'messages#revealed'

  get 'likes'                => 'wall#likes'
  get 'favorites'            => 'wall#favorites'

  get 'store'                => 'products#store'
  get 'visitors'             => 'users#visitors'
  get 'links'                => 'links#index'
  get 'authors'              => 'authors#index'
  get 'quotes'               => 'quotes#index'
  get 'quote_types'          => 'quote_types#index'
  get 'ads'                  => 'ads#index'
  get 'feedbacks'            => 'feedbacks#index'

	post 'send-feedback'       => 'feedbacks#create'
  get 'products'             => 'products#index'
  get 'payments'             => 'payments#index'
	get 'orders'               => 'orders#index'
  get 'invoices'             => 'invoices#index'
  get 'store'                => 'products#store'

  post 'express-checkout'    => 'carts#express_checkout'
  get 'subscribe'            => 'carts#show'
  post 'express'             => 'orders#express'
  post 'update-cart'         => 'carts#update_cart'

  get 'contribution'   => 'charges#new'

  get 'tags'           => 'tags#index'
  get 'idtag'          => 'posts#idtag'

  get 'posts'          => 'posts#index'

  get 'taggings'       => 'posts#taggings'

  get 'notifications'  => 'updates#index'
  get 'updates'        => 'updates#{@i}index'
  get 'blocked'        => 'blocked_users#index'
  get 'banned'         => 'blocked_users#index'
  get 'invitations'    => 'invitations#index'
  get 'requests'       => 'requests#index'
  get 'gallery'        => 'pictures#index'
  get 'pictures'       => 'pictures#index'
  get 'images'         => 'pictures#index'
  get 'home'           => 'users#home'

  post 'upload-picture'=> 'pictures#create'


  get 'superlogin'     => 'index#superlogin'

  get 'blog'           => 'posts#blog'
  get 'blog-settings'  => 'posts#settings'
  #get 'blog2'          => 'posts#blog2'

  post 'savesettings'  => 'posts#savesettings'
  get 'd4x337'      => 'posts#d4x337'
  get 'blog-tags'      => 'tags#index'
  get 'blog-author'    => 'posts#d4x337'
  get 'tags-d4x337'    => 'posts#tags'
  get 'author-d4x337'  => 'posts#d4x337'
  post 'like'          => 'mini_posts#like'
  post 'liked'         => 'mini_posts#liked'
  post 'liking'        => 'mini_posts#liking'
  post 'disliking'     => 'mini_posts#disliking'
  post 'favoriting'    => 'mini_posts#favoriting'
  post 'sharel'        => 'wall#sharel'
  post 'sharep'        => 'wall#sharep'

  get 'timeline'       => 'timeline#index'
  get 'atimeline'      => 'timeline#admin'

  get 'wall'           => 'wall#index'
  get 'lounge'         => 'wall#index'
  get 'updwall'        => 'wall#indexupd'

  get 'requests'       => 'requests#index'
  get 'network'        => 'friends#index'
  get 'connections'    => 'friends#index'

  get 'domains'        => 'domains#index'
  get 'alias-maps'     => 'alias_maps#index'
  get 'mail-accounts'  => 'mail_accounts#index'

  get 'friends'        => 'friends#index'
  get 'dashboard'      => 'dashboard#index'
  get 'sha512'         => 'shadow#index'
  get 'close-account'  => 'messages#close_account'
  get 'directory'      => 'search#directory'
  get 'avatar'         => 'messages#avatar'
  get 'passphrase'     => 'messages#passphrase'
  #get 'myprofile'      => 'messages#myprofile'
  #get 'profile'      => 'messages#profile'

  get 'profile'      => 'users#profile'

  get 'setstatus'      => 'messages#status'
  get 'privacy-settings'=> 'messages#privacy_settings'
  get 'language'       => 'messages#language'
  get 'cropavi'        => 'messages#crop'
  get 'tell-a-friend'  => 'messages#tell_a_friend'
  get 'info'           => 'messages#info'
  get 'settings'       => 'messages#settings'

  get 'compose'        => 'messages#compose'
  get 'compose2'       => 'messages#compose2'
  get 'reveal'         => 'messages#reveal'
  get 'contacts'       => 'contacts#index'
  get 'sent'           => 'messages#sent'
  get 'received'       => 'messages#received'
  get 'reveal'         => 'messages#reveal'  
  get 'efiles'         => 'efiles#index'
  get 'search'         => 'search#index'
  get 'messages'       => 'messages#index'
  get 'read_message'   => 'messages#read_message'
  post 'go-to-category'=> 'search#go_to_category'
  get 'complete'       => 'search#complete'
  get 'about'         => 'index#about'
  get 'about2'         => 'index#about2'
  get 'terms'         => 'index#terms'
  get 'index'         => 'index#index'
  get 'indexnew'      => 'index#indexnew'
  post 'setcoupon'    => 'index#setcoupon'
  post 'addcoupon'    => 'index#addcoupon'
  post 'checknick'    => 'index#checknick'
  post 'checkemail'   => 'index#checkemail'
  get 'options'       => 'options#index'
  get 'accounts'      => 'users#index'


  post 'savedraft'           => 'agadanga#save_draft'
  post 'discard'             => 'agadanga#discard'
  post 'send'                => 'agadanga#send'

  get 'reply'                => 'agadanga#agadanga_reply'

  post 'reply-forward'       => 'agadanga#actions'
  post 'actions'             => 'agadanga#actions'

  get 'payments'             => 'payments#index'
  get 'incomes'              => 'incomes#index'
  get 'organization'         => 'staff#index'
  get 'mailboxes'            => 'mail_accounts#index'

  get 'agadanga-settings'    => 'agadanga#agadanga_settings'
  get 'agadanga-trash'       => 'agadanga#agadanga_trash'
  get 'agadanga-keys'        => 'agadanga#agadanga_keys'
  get 'agadanga-address-book'=> 'contacts#index'
  get 'agadanga-flagged'     => 'agadanga#agadanga_flagged'


  get 'reply-all'            => 'agadanga#agadanga_reply_all'
  get 'reply'                => 'agadanga#agadanga_reply'
  get 'forward'              => 'agadanga#agadanga_forward'
  get 'inbox'                => 'agadanga#agadanga_inbox'
  get 'sent-box'             => 'agadanga#agadanga_sent'
  get 'drafts'               => 'agadanga#agadanga_drafts'
  get 'draft'                => 'agadanga#agadanga_drafts'
  get 'junk'                 => 'agadanga#agadanga_junk'
  get 'spam'                 => 'agadanga#agadanga_junk'
  get 'archive'              => 'agadanga#agadanga_archivied'
  get 'important'            => 'agadanga#agadanga_important'
  get 'compose-email'        => 'agadanga#agadanga_compose'
  get 'refresh'              => 'agadanga#agadanga_refresh'
  get 'agadanga-settings'    => 'agadanga#agadanga_settings'
  get 'trash'                => 'agadanga#agadanga_trash'
  get 'keys'                 => 'agadanga#agadanga_keys'
  get 'agadanga-send'        => 'agadanga#agadanga_send'
  get 'agadanga-discard'     => 'agadanga#discard'
  get 'agadanga-save-draft'  => 'agadanga#save_draft'
  get 'pr-dashboard'         => 'invitations#index'
  get 'agadanga-orders'      => 'agadanga#agadanga_orders'
  get 'agadanga-partners'    => 'agadanga#agadanga_partners'
  get 'agadanga-dashboard'   => 'agadanga#agadanga_dashboard'
  post 'agadanga-archive'    => 'agadanga#agadanga_bigbutton_archive'
  post 'agadanga-set-junk'   => 'agadanga#agadanga_bigbutton_set_junk'
  post 'agadanga-delete'     => 'agadanga#agadanga_bigbutton_delete'
  post 'agadanga-flag'       => 'agadanga#agadanga_bigbutton_mark_important'
  post 'read-message'        => 'agadanga#read_message'

  #get '/:nickname' => 'users#show', :as => 'vanity_url'
end
