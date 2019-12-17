class Product < ActiveRecord::Base
  belongs_to :category, required: false
end
