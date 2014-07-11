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

# add other js here
//= require front/common/base
//= require front/common/sign_in
//= require front/all

//= require turbolinks

