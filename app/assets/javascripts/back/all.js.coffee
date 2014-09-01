## 由于使用了turbolinks,所以这里要注册这个事件
$(document).on 'ready page:load', ->
  ## date选择picker
  ### 
  $("[car_date_picker]").datetimepicker({
    format: "yyyy-mm-dd",
    todayBtn: "linked",
    language: "zh-CN",
    # feather dairg 设置可以预约的开始结束时间
    startDate: (new Date()).addDays(1),
    endDate: (new Date()).addDays(15),
    orientation: "bottom right",
    daysOfWeekDisabled: "0,6",
    autoclose: true,
    todayHighlight: true,
    minView: 2
  })
  ### 

  # a Date range as a button
  date_range_start = moment().subtract('days', 29)
  date_range_end = moment()
  if $('.car-date-range-from').val() != ''
    date_range_start = $('.car-date-range-from').val()
  if $('.car-date-range-to').val() != ''
    date_range_end = $('.car-date-range-to').val()

  $('#daterange-btn').daterangepicker({
    ranges: {
        '今天': [moment(), moment()],
        '昨天': [moment().subtract('days', 1), moment().subtract('days', 1)],
        '最近7天': [moment().subtract('days', 6), moment()],
        '最近30天': [moment().subtract('days', 29), moment()],
        '本月': [moment().startOf('month'), moment().endOf('month')],
        '上个月': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
    },
    opens: 'right',
# startDate: moment().subtract('days', 29),
# endDate: moment(),
    startDate: date_range_start,
    endDate: date_range_end,
    format: 'YYYY-MM-DD',
    locale: { cancelLabel: '清空', applyLabel: '确定', customRangeLabel: '选择时间范围', fromLabel: '从', toLabel: '到'}
  }, (start, end) ->
    $('.car-date-range-from').val(start.format('L'))
    $('.car-date-range-to').val(end.format('L'))
  )

  $('#daterange-btn').on 'cancel.daterangepicker', (ev, picker) ->
    $('.car-date-range-from').val('')
    $('.car-date-range-to').val('')

  # 拒绝modal中提交按钮click处理
  $('#btn_reject_submit').on 'click', ->
    if $('#reject_reason_text').val().length == 0
      $('#reject_box_alert').html('请输入拒绝理由!')
      $('#reject_box_alert').removeClass('display_none')
      $('#reject_reason_text').parents('div.car-form-items').addClass('has-error')
      return false
    else
      return true

