module PersonalMessagesHelper
  def get_file_type_tag message
    message.is_video? ? video_tag(message.avatar.url(:medium), controls: true, autobuffer: true) : image_tag(message.avatar.url(:medium))
  end
end
