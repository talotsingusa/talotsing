class MessageMailer < ApplicationMailer
  default from: "Talotsing <noreply@example.com>"

  helper ApplicationHelper
  def order_email(email, name, user, url, order)
    @to = email
    @body = "#{user.first_name} #{user.last_name}"
    @url= url
    @name = name
    @order = order
    @user = user
    @subject = "Order Confirmation"
    mail(to: @to, from: "Talotsing", subject: @subject, body: @body) do |format|
      format.html { render 'message_mailer/order_email' }
    end

  end

  def email_admin(user, url, order)
    @to = "info@talotsing.com"
    @body = "#{user.first_name} #{user.last_name}"
    @url= url
    @name = "Talotsing"
    @order = order
    @user = user
    @subject = "New Order"
    mail(to: @to, from: "Talotsing", subject: @subject, body: @body) do |format|
      format.html { render 'message_mailer/email_admin' }
    end

  end

end
