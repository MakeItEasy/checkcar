Date.prototype.addDays = function(days) {
  var dat = new Date(this.valueOf());
  dat.setDate(dat.getDate() + days);
  return dat;
};

$(function() {
  // mask的使用，比如手机号码输入的mask 99999999999
  $("[data-mask]").inputmask();
});
