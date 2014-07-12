###
  共通的错误处理类
    -> 使用注意事项
      1.要添加car_id_prefix属性到form
      2.要保证所有输入以及wrapper的都有ID，并且id为 #{car_id_prefix}_#{error.key}
      3.form要有car_common_handler属性
###
class @CommonErrorHandler
  constructor: (@form, @key_id, @errText) ->
  
  execute: ->
    source_wrapper = @form.find("div.#{@key_id}")
    source = @form.find("##{@key_id}")
    if @errText
      source_wrapper.addClass("has-error")
      source.focus()
      source.after("<span class='help-inline'>#{@errText}</span>")
    else
      source_wrapper.removeClass("has-error")
      source_wrapper.find("span.help-inline").remove()
