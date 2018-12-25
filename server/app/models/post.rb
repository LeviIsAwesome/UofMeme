class Post < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :dislikes, dependent: :destroy
	attr_accessor :uploaded_image_for_io_adapters, :file_name, :top_text, :bot_text

	
	has_attached_file :image, styles: {   
		square: "250x250#",
		medium: "350x400!",
    large:  "500x550!"
	}, 
    :convert_options => {
      :medium => "-quality 100 -strip"
    }, 
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment :image, presence: true
  validates_presence_of :poster
	validates_presence_of :description
	validates :user, presence: true
	validates :user_id, presence: true
end



