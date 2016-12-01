class Product < ApplicationRecord
  mount_uploader :image, PictureUploader
  
  has_many  :line_items
  has_many  :orders,  :through  =>  :line_items
  validates  :title,  :description,  :image,  :presence  =>  true
  validates  :price,  :numericality  =>  {:greater_than_or_equal_to  =>  0.01}
  validates  :title,  :uniqueness  =>  true
  validates  :image,  :format  =>  {:with  =>  /\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/,  :multiline => true,  :message  =>  'must be a url for git,jpg or png  image'  }

  private
    def  ensure_not_referenced_by_any_line_item
      if  line_items.empty?
      	return true
      else
      	errors.add(:base,  'Line Items  present')
      	return false
      end
    end
end
