class Comment < ActiveRecord::Base
  belongs_to :article
  validates :commenter, presence: true
  validates :body, presence: true

  #after_create :send_email_to_article_author

  def send_email_to_article_author
  	UserMailer.comment_notification(self.article.user.email).deliver
  end

end
