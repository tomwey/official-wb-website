class Project < ActiveRecord::Base
  validates :name, :body, :cover, presence: true
  
  validate :require_tags
  
  mount_uploader :cover, CoverImageUploader
  
  before_create :generate_unique_id
  def generate_unique_id
    begin
      n = rand(10)
      if n == 0
        n = 8
      end
      self.uniq_id = (n.to_s + SecureRandom.random_number.to_s[2..8]).to_i
    end while self.class.exists?(:uniq_id => uniq_id)
  end
  
  before_save :remove_blank_value_for_array
  def remove_blank_value_for_array
    self.tags = self.tags.compact.reject(&:blank?)
  end
  
  def require_tags
    if self.tags.empty?
      errors.add(:base, '必须设置至少一个标签')
      return false
    end
  end
  
  def tag_names
    names = []
    self.tags.each do |tag|
      tag1 = Tag.find_by(code: tag)
      names << Tag.find_by(code: tag).try(:name)
    end
    names.join(',')
  end
  
  def add_visit
    self.class.increment_counter(:visit, self.id)
  end
  
end
