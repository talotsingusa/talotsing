class MessageMailer < ApplicationMailer
  default from: "talotsing@gmail.com"
  helper ApplicationHelper
  def order_email(email, name, user, url, order)
    @to = email
    @body = "#{user.first_name} #{user.last_name}"
    @url= url
    @name = name
    @order = order
    @user = user
    # attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/logoo 3.png")
    mail(to: @to, subject: @subject, body: @body) do |format|
      format.html { render "message_mailer/order_email" }
    end
  end
end
