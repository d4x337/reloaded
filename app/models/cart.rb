class Cart < ActiveRecord::Base

#   attr_accessible :user_id
#   acts_as_shopping_cart
#   has_many :cart_items,:class_name=>'CartItem',:foreign_key=>:cart_id, :dependent => :destroy
    has_many :cart_products,:class_name=>'CartProduct',:foreign_key=>:cart_id, :dependent => :destroy
  
  def test_paypal_url(return_url,notify_url)
   values = {
      :business => 'system-facilitator@agadanga.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id,
      :currency_code=>'EUR',
      :notify_url => notify_url
      
    }
    cart_products.each_with_index do |item, index|
      product = Product.find(item.product_id)
      values.merge!({
        "amount_#{index+1}" => item.single_price,
        "item_name_#{index+1}" => product.name,
        "item_number_#{index+1}" => item.product_id,
        "quantity_#{index+1}" => item.quantity
      })
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
  
  def paypal_url(return_url,notify_url)
    values = {
      :business => 'system@agadanga.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id,
      :currency_code=>'EUR',
      :notify_url => notify_url
    }
    cart_products.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.single_price,
        "item_name_#{index+1}" => item.status,
        "item_number_#{index+1}" => item.product_id,
        "quantity_#{index+1}" => item.quantity
      })
    end
    "https://www.paypal.com/cgi-bin/webscr?" + values.to_query
  end
  
 def test_paypal_encrypted(return_url, notify_url)
    values = {
      :business => 'system-facilitator@agadanga.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id,
      :currency_code=>'EUR',
      :notify_url => notify_url,
      :cert_id => "PB8AKC7XAV98L"
    }
    cart_products.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.single_price,
        "item_name_#{index+1}" => item.status,
        "item_number_#{index+1}" => item.product_id,
        "quantity_#{index+1}" => item.quantity
      })
    end
   
    test_encrypt_for_paypal(values)
  end
 
  TEST_PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs_test/paypal_cert.pem")
  TEST_APP_CERT_PEM = File.read("#{Rails.root}/certs_test/app_cert.pem")
  TEST_APP_KEY_PEM = File.read("#{Rails.root}/certs_test/app_key.pem")
 
  def test_encrypt_for_paypal(values)
      signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(TEST_APP_CERT_PEM), OpenSSL::PKey::RSA.new(TEST_APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
      OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(TEST_PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end
 
  
  def paypal_encrypted(return_url, notify_url)
    values = {
      :business => 'system@agadanga.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id,
      :currency_code=>'EUR',
      :notify_url => notify_url,
      :cert_id => "F3FVFB3QEHVFC"
    }
    cart_products.each_with_index do |item, index|
      product = Product.find(item.product_id)
      values.merge!({
        "amount_#{index+1}" => item.single_price,
        "item_name_#{index+1}" => product.name,
        "item_number_#{index+1}" => item.product_id,
        "quantity_#{index+1}" => item.quantity
      })
    end
   
    encrypt_for_paypal(values)
  end
  
  PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")
  
  def encrypt_for_paypal(values)
      signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
      OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end
  
end
