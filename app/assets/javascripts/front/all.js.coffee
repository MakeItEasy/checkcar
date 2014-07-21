## 由于使用了turbolinks,所以这里要注册这个事件
$(document).on 'ready page:load', ->
  ## 账号登录modal框的登录处理
  $("#sign_in_remote_form").on("ajax:success", (e, data, status, xhr) ->
    location.reload()
  ).on "ajax:error", (e, xhr, status, error) ->
    # TODO dairg error处理
    alert(xhr.responseJSON.error)
    $('#sign_in_remote_form img.car-captcha').attr "src", (index, attr) ->
      getCaptchaUrl()

  ## 手机动态登录modal框的登录处理
  $("#sign_in_remote_form_phone").on("ajax:success", (e, data, status, xhr) ->
    location.reload()
  ).on "ajax:error", (e, xhr, status, error) ->
    # TODO dairg error处理
    alert(xhr.responseJSON.error)
    $('#sign_in_remote_form_phone img.car-captcha').attr "src", (index, attr) ->
      getCaptchaUrl()

  ## 登录按钮的click处理：如果已经登录，那么刷新本页面，如果没有，弹出登录框
  $('#btn_sign_in').click (e) -> 
    $.get "/sign_in_status.json", (data) ->
      if data
        location.reload()
      else
        $('#signinModal').modal('show')

  ## 在切换登录modal窗口的tab时，验证码刷新
  $('#car-tab-sign-in a[data-toggle="tab"]').on 'show.bs.tab', ->
    $($(this).attr("href")).find("img").attr "src", (index, attr) ->
      getCaptchaUrl()

  ## 登录modal框显示时，验证码刷新
  $('#signinModal').on 'show.bs.modal', ->
    $($("#car-tab-sign-in > li.active > a").attr("href")).find("img.car-captcha").attr "src", (index, attr) ->
      getCaptchaUrl()

  ## 我要提问按钮的click处理：如果已经登录，那么刷新本页面，如果没有，弹出登录框
  $('#have_question').click (e) -> 
    if $('#haveQuestionModal').length
      $('#haveQuestionModal').modal("show")
    else
      $.get "/sign_in_status.json", (data) ->
        if data
          location.reload()
        else
          $('#signinModal').modal('show')

  ## 通用form的ajax错误处理
  $("form[data-remote=true][car_common_handler]").on("ajax:success", (e, data, status, xhr) ->
    $(this).find(".has-error").removeClass("has-error")
    $(this).find(".help-inline").remove()
    $(this).find("textarea").val("")
  ).on "ajax:error", (e, xhr, status, error) ->
    car_id_prefix = $(this).attr('car_id_prefix')
    for key, errors of xhr.responseJSON
      new CommonErrorHandler($(this), "#{car_id_prefix}_#{key}", errors[0]).execute()

  $("form#new_uaq").on "ajax:success", (e, data, status, xhr) ->
    $('#haveQuestionModal').modal("hide")
    $('#questionSuccessModal').modal("show")

  ## date选择picker
  $("[car_date_picker]").datetimepicker({
    format: "yyyy-mm-dd",
    language: "zh-CN",
    # TODO dairg 设置可以预约的开始结束时间
    startDate: (new Date()).addDays(1),
    endDate: (new Date()).addDays(15),
    orientation: "bottom right",
    daysOfWeekDisabled: "0,6",
    autoclose: true,
    todayHighlight: true,
    minView: 2
  })
