## 由于使用了turbolinks,所以这里要注册这个事件
$(document).on 'ready page:load', ->
  ## date选择picker
  $("[car_date_picker]").datetimepicker({
    format: "yyyy-mm-dd",
    todayBtn: "linked",
    language: "zh-CN",
    # TODO dairg 设置可以预约的开始结束时间
    startDate: new Date(),
    endDate: (new Date()).addDays(15),
    orientation: "bottom right",
    daysOfWeekDisabled: "0,6",
    autoclose: true,
    todayHighlight: true,
    minView: 2
  })
