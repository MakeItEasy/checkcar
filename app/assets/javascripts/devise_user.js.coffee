//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require twitter/bootstrap

$(document).on 'ready page:load', ->
  # 验证码点击重载
  $("img[alt='captcha']").each (index, item) ->  
    item.title = '看不清？点击刷新'  
  $('img.car-captcha').click (e) -> 
    this.src = this.src + '?'  
