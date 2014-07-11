################################################################### 
# 手机动态码的错误处理类
################################################################### 
class AuthCodeErrorHandler
  constructor: (@source, @errText) ->
  
  execute: ->
    if @errText
      @source.addClass("has-error")
      @source.find("input").focus()
      @source.after("<div class='car-error-tip'>" + @errText + "</div>")
    else
      @source.removeClass("has-error")
    # 刷新验证码
    $('div#car-wrapper-captcha-phone').find("img.car-captcha").attr "src", (index, attr) ->
      attr


# 由于使用了turbolinks,所以这里要注册这个事件
$(document).on 'ready page:load', ->

  ################################################################### 
  # 获取手机动态码button的click处理
  ################################################################### 
  $('#get_yanzhengma').click (e) ->
    btn = $(this)
    # 请求动态验证码
    authAjax = $.post "/phone_authcode.json", {phone: $("#telephone").val() , captcha: $("#captcha_phone").val() },  (data) ->
      # 删除所有的错误提示
      $('div.car-error-tip').remove()
      if data['errors']
        new AuthCodeErrorHandler($('div#car-wrapper-captcha-phone'), data['errors']["captcha"]).execute()
        new AuthCodeErrorHandler($('div#car-wrapper-phone-authcode'), data['errors']["phone"]).execute()
        $('div#car-wrapper-captcha-phone input').val("")
      else
        new AuthCodeErrorHandler($('div.car-captcha')).execute()
        new AuthCodeErrorHandler($('div.car-phone-authcode')).execute()
        $('div#car-wrapper-captcha-phone input').val("")
        seconds = 60
        # 计时器
        callback_yanzheng = ->
          if seconds <= 0
            clearInterval(countDown)
            btn.removeAttr("disabled").removeClass("disabled").html("点击获取手机动态码")
          else
            btn.attr("disabled", "disabled").addClass("disabled").html("请注意查收手机，" + seconds-- + "秒后重新获取!")
        callback_yanzheng()
        countDown = setInterval(callback_yanzheng, 1000)
