###
特别注意这个顺序，参照jquery.turbolinks readme
jquery.turbolinks 必须在jquery 和jquery_ujs的后面，然后在turbolinks的前面
###
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.turbolinks
//= require bootstrap
//= require adminlte/AdminLTE
//= require jquery/input-mask/jquery.inputmask
//= require jquery/input-mask/jquery.inputmask.regex.extensions
//= require bootstrap-datetimepicker/bootstrap-datetimepicker
//= require bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN

# add other js here
//= require common/car_base
//= require front/common/class
//= require front/common/base
# 获取手机验证码的动态处理
//= require front/common/sign_in
//= require front/all

//= require turbolinks

