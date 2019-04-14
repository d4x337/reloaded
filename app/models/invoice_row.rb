class InvoiceRow < ActiveRecord::Base
  attr_accessible :product_id, :single, :quantity, :total, :vats, :in_stock, :arrival_date, :shipped,:payed
end
