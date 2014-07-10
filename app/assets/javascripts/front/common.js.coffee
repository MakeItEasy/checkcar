# 由于使用了turbolinks,所以这里要注册这个事件
$(document).on 'ready page:load', ->
  # 登录modal框的登录处理
  $("#sign_in_remote_form").on("ajax:success", (e, data, status, xhr) ->
    location.reload()
  ).on "ajax:error", (e, xhr, status, error) ->
    alert(xhr.responseJSON.error)
    $('img.car-captcha').attr("src", $('img.car-captcha').attr("src"))

  # 登录按钮的click处理：如果已经登录，那么刷新本页面，如果没有，弹出登录框
  $('#btn_sign_in').click (e) -> 
    $.get "/sign_in_status.json", (data) ->
      if data
        location.reload()
      else
        $('#signinModal').modal('show')
