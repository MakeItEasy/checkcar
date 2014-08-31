class OrderMailer < ActionMailer::Base
  def new_reminder
    mail(to: "rugang6891@163.com", subject: '订单成功')
  end
end
