class Article < ActiveRecord::Base

  belongs_to :author, polymorphic: true
  belongs_to :category, class_name: ArticleCategory
  has_many :content_likes, as: :likeable, dependent: :destroy

  has_attached_file :image, :styles => { :medium => "400x400>", :thumb => "100x100>" } #, :default_url => "placeholder-image.png"  #, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  has_attached_file :pdf
  do_not_validate_attachment_file_type :pdf

  validates :category, presence: true
  validates :author, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :description, length: { maximum: 500 }
  validates :body, presence: true
  validates :imported_url, uniqueness: true, allow_blank: true

  before_create :set_published_at
  before_validation { self.image.clear if self.delete_image == '1' }

  attr_accessor :delete_image

  scope :featured, -> { where(featured: true) }
  scope :to_anybody, -> { where(public: true) } # "public" no se puede usar (to_all, shared, free_to_all, open, not_private, ...)
  scope :by_category, -> (category) { where(category: ArticleCategory.where(code: category).try(:ids)) }
  scope :news, -> { by_category(['incyde', 'current']) }
  scope :promotions, -> { by_category('promotions') }
  scope :by_admin, -> { where(author_type: "Admin") }
  scope :by_business_incubator, -> { where(author_type: "BusinessIncubator") }
  #scope :by_user, lambda {|user|  where(author_type: "BusinessIncubator", author_id: user.id) } # ¿Forzar el tipo o usar el método para cualquier tipo de usuario?
  #scope :by_user, lambda {|user|  where(author_type: user.class.name, author_id: user.id) }
  scope :by_user, -> (user)  {where(author_type: user.class.name, author_id: user.id) } # ¿Es lo mismo que lambda?
  scope :ordered, -> {order('published_at desc')}

  scope :visible_for, -> (user){
      if user.is_a?(Admin)
        all
      elsif user.is_a?(BusinessIncubator)
        #where("author_type = 'Admin' OR (author_type = 'BusinessIncubator' AND author_id = ?) OR (author_type = 'BusinessIncubator' AND public = true)", user.id)
        where("public = true OR author_type = 'Admin' OR (author_type = 'BusinessIncubator' AND author_id = ?)", user.id)
      elsif user.is_a?(Company)
        where("public = true OR (author_type = 'BusinessIncubator' AND author_id = ?)", user.company_profile.business_incubator_profile.business_incubator_id)
      end
  }


  def has_image?
    image_url.present? || image?
  end

  def get_image_url(size=nil)
    image_url.presence || image.url(size)
  end

  rails_admin do
    weight -1 # Lleva esta opción de menú al principio
    list do
      field :category
      field :image
      field :author do
        visible do
          bindings[:controller].current_user.is_a? Admin
        end
      end
      field :title
      # field :description
      field :featured
      field :public
    end
    edit do
      field :category
      field :title
      field :description
      #field :body
      field :body, :froala do
        # https://www.froala.com/wysiwyg-editor/v1.2/docs/options
        config_options do
          {
              buttons: ['formatBlock', 'bold', 'italic', 'underline', 'align', 'insertOrderedList', 'insertUnorderedList', 'outdent', 'indent', 'createLink', 'insertImage', 'html'],
              # imageUpload: false,
              # imageUploadURL: false,
              # pasteImage: false,
              # imageLink: false,
              height: '300'
          }
        end
      end
      # field :body, :wysihtml5 do
      #   config_options :html => true,
      #                  image: false
      # end
      field :featured
      field :public
      field :image
      field :video_url
      field :published_at do
        visible do
          !bindings[:object].new_record?
        end
      end
      field :pdf
    end
    show do
      field :category
      field :image
      field :author do
        visible do
          bindings[:controller].current_user.is_a? Admin
        end
      end
      field :title
      field :description
      field :body do
        pretty_value do
          bindings[:object].body.html_safe
        end
      end
      field "featured" do
        pretty_value do
          bindings[:object].featured
        end
      end
      field :public
      field :featured
      field :video_url
      field :published_at
      field :created_at
      field :pdf
    end
    #configure :title do
    #  #label 'Owner of this ball: '
    #end
  end

  private

  def set_published_at
    self.published_at ||= Time.now
  end

end
