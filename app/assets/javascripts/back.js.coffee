###
特别注意这个顺序，参照jquery.turbolinks readme
jquery.turbolinks 必须在jquery 和jquery_ujs的后面，然后在turbolinks的前面
###
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require wice_grid
//= require wice_grid_car
//= require jquery.turbolinks
//= require bootstrap
//= require adminlte/AdminLTE
//= require jquery/input-mask/jquery.inputmask
# TODO dairg 是否可以注释掉？
# require ckeditor/override
//= require ckeditor/init
//= require china_city/jquery.china_city
# add other js here
//= require back/common

//= require turbolinks

