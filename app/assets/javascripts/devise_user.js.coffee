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

  # 手机动态码
  $('#get_yanzhengma').click (e) ->
    btn = $(this)
    seconds = 60
    callback_yanzheng = ->
      if seconds <= 0
        clearInterval(countDown)
        btn.removeAttr("disabled").removeClass("disabled").html("点击获取手机动态码")
      else
        btn.attr("disabled", "disabled").addClass("disabled").html("请注意查收手机，" + seconds-- + "秒后重新获取!")
    callback_yanzheng()
    countDown = setInterval(callback_yanzheng, 1000)
