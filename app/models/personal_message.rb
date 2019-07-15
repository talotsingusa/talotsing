class PersonalMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates :body, presence: true

  has_attached_file :avatar, styles: lambda { |a| a.instance.is_image? ? { medium: "300x300>", thumb: "100x100>", big: "1200x1200>", normal: "600x600>" } : { thumb: { geometry: "100x100#", format: 'jpg', time: 10}, medium: { geometry: "300x300#", format: 'jpg', time: 10, processors: [:ffmpeg]}}}


  validates_attachment_content_type :avatar, content_type: %w(video/mp4 video/3gp video/webm image/jpeg image/jpg image/png)

  def is_video?
    avatar.content_type =~ %r(video)
  end

  def is_image?
    avatar.content_type =~ %r(image)
  end
  after_create_commit do
    conversation.touch
    NotificationBroadcastJob.perform_later(self)
  end
end
