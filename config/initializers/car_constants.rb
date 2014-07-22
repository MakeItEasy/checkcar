module Car
  module Constants
    # 不用显示small title在page header上的controller 名称一览
    NO_SUB_TITLE_CONTROLLER_LIST = ['dashboard']

    # 手机动态码有效时间 30分钟
    PHONE_AUTHCODE_EXPIRES = 60*30

    # 默认可预约天数
    ORDER_DEFAULT_ENABLE_DAYS = 10

    # 可取消预约天数(从今天开始?天以后)
    # TODO dairg 可取消的天数限制
    ORDER_CANCEL_ENABLE_DAYS = 2
  end
end
