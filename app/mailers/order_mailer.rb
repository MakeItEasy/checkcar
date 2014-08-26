class OrderMailer < ActionMailer::Base
  default from: "rugang6891@163.com"

  def new_reminder
    mail(to: "rugang6891@gmail.com", subject: '订单成功')
  end
end
