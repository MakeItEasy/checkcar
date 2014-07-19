Date.prototype.addDays = function(days) {
  var dat = new Date(this.valueOf());
  dat.setDate(dat.getDate() + days);
  return dat;
};

$(function() {
  // mask的使用，比如手机号码输入的mask 99999999999
  $("[data-mask]").inputmask();

  // 车牌号码的输入控制
  $("#order_phone_car_number_detail, #order_net_car_number_detail").inputmask("Regex",
    {regex: "[A-Za-z0-9]{6}", clearIncomplete: true});
  $("#order_phone_car_number_detail, #order_net_car_number_detail").keypress(function() {
    // 自动转换大写
    $(this).val($(this).val().toUpperCase());
  });

});
