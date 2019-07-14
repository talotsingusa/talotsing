module ConversationsHelper
  def user_chat_image message
    return 'admin.jpg' if message.user.admin?
    message.user.image.present? ? message.user.image : 'user.png'
  end
end
