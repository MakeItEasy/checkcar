module Car
  module Constants
    # 不用显示small title在page header上的controller 名称一览
    NO_SUB_TITLE_CONTROLLER_LIST = ['dashboard']

    # 手机动态码有效时间 30分钟
    PHONE_AUTHCODE_EXPIRES = 60*30

    # 默认可预约天数
    ORDER_DEFAULT_ENABLE_DAYS = 10

    # 可取消预约天数(从今天开始?天以后)
    # TODO dairg(客户确认) 可取消的天数限制, 以及这里所有的设置都要确认
    ORDER_CANCEL_ENABLE_DAYS = 2

    # 用户可同时预约的数量
    USER_ENABLE_ORDER_NUMBERS = 3

    # 车检站展示图片的数量
    STATION_PICTURES_MAX_COUNT = 3

    # front前台每页展示的车检站数量
    PER_COUNT_FOR_FRONT_STATIONS = 10

    # 车检站预约数量设置的最大值
    TIME_AREA_SETTING_MAX = 20
  end
end
