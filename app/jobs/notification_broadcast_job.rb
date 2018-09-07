class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(personal_message)
    message = render_message(personal_message)
    recipient = get_recipient_id(personal_message)
    ActionCable.server.broadcast "notifications_#{personal_message.user.id}_channel",
                                 message: message,
                                 conversation_id: personal_message.conversation.id


    ActionCable.server.broadcast "notifications_#{recipient}_channel",
                                 notification: render_notification(personal_message),
                                 message: message,
                                 conversation_id: personal_message.conversation.id
  end

  private

  def render_notification(message)
    NotificationsController.render partial: 'notifications/notification', locals: {message: message}
  end

  def render_message(message)
    PersonalMessagesController.render partial: 'personal_messages/personal_message',
                                      locals: {personal_message: message}
  end

  def get_recipient_id(message)
    conversation_id = message.conversation_id
    @conversation = Conversation.find(conversation_id)
    if @conversation.author_id == message.user_id
      receiver_id = @conversation.receiver_id
    elsif @conversation.receiver_id == message.user_id
      receiver_id = @conversation.author_id
    end
    return receiver_id
  end
end
