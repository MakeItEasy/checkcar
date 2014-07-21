Date.prototype.addDays = (days) -> 
  dat = new Date(this.valueOf());
  dat.setDate(dat.getDate() + days);
  return dat;

$(document).on 'ready page:load', ->
  ## mask的使用，比如手机号码输入的mask 99999999999
  $("[data-mask]").inputmask()

  ## 车牌号码的输入控制
  $("#order_phone_car_number_detail, #order_net_car_number_detail").inputmask("Regex",
    {regex: "[A-Za-z0-9]{6}", clearIncomplete: true})
  $("#order_phone_car_number_detail, #order_net_car_number_detail").keypress ->
    # 自动转换大写
    $(this).val($(this).val().toUpperCase());

  ## 预约step select date时，单选框样式
  $(".car-order-select-time-table input[type='radio']").iCheck({
    checkboxClass: 'icheckbox_square-green',
    radioClass: 'iradio_square-green'
  })

  ## 当鼠标经过单选框时，显示tips
  $(".car-order-select-time-table ins.iCheck-helper").hover () ->
    $(this).parent().parent().tooltip "show"
  , () ->
    $(this).parent().parent().tooltip "hide"

  $(".car-order-select-time-table input[type='radio']").on 'ifChecked', (event) ->
    html_content = '<span class="label label-success" style="font-size: 100%;">已选择时间段：'  + $(this).val() + '</span>'
    $("#select_time_info").html html_content
