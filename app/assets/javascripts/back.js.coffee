###
特别注意这个顺序，参照jquery.turbolinks readme
jquery.turbolinks 必须在jquery 和jquery_ujs的后面，然后在turbolinks的前面
###
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.ui.datepicker-zh-CN
//= require daterangepicker/moment
//= require daterangepicker/moment_locale/zh-cn
//= require daterangepicker/daterangepicker
//= require wice_grid
//= require wice_grid_car
//= require jquery.turbolinks
//= require bootstrap
//= require adminlte/AdminLTE
//= require jquery/input-mask/jquery.inputmask
//= require jquery/input-mask/jquery.inputmask.date.extensions
//= require jquery/input-mask/jquery.inputmask.regex.extensions
# 项目地址:https://github.com/smalot/bootstrap-datetimepicker
# fork源项目：https://github.com/eternicode/bootstrap-datepicker
//= require bootstrap-datetimepicker/bootstrap-datetimepicker
//= require bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN
# TODO dairg ckeditor/override是否可以注释掉？
# require ckeditor/override
//= require ckeditor/init
//= require china_city/jquery.china_city
# ==============================================
# 我的js add other js here
# ==============================================
//= require common/car_base
//= require back/all

//= require turbolinks

