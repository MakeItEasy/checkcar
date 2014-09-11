FactoryGirl.define do
  sequence :car_number_detail do |n|
    "A0000#{n}"
  end

  factory :order_net do
    # 车牌号
    car_number_area "陕"
    car_number_detail
    # 预约者
    user
    # 预约车检站
    station
    # 预约时间
    order_time { Time.now.beginning_of_day + 11.hours }
    # 车主姓名
    owner_name "张三"
    # 预留手机号
    telephone "18100000001"
  end
end
