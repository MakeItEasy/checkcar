class Car::OrderState

  def initialize(station, start_date = Date.tomorrow, days = Car::Constants::ORDER_DEFAULT_ENABLE_DAYS)
    if start_date > Date.tomorrow
      @start_date = start_date
    else
      @start_date = Date.tomorrow
    end
    @station = station
    @days = days
  end

  def current_order_states
    init_order_states
    orders = @station.orders.success.select("order_time, count(order_time) as count_orders").group("order_time")
            .where(order_time: (@start_date..@start_date+@space_day))
            .order(order_time: :asc)
    orders.each do |item|
      _date = item.order_time.to_date
      _index = item.order_time.hour - 10
      if @order_states[_date][_index] > 0
        @order_states[_date][_index] -= item.count_orders
      end
    end
    @order_states
  end

private
  def init_order_states
    @order_states = {}
    day = 1
    # 间隔了多少天
    @space_day = 0

    while day <= @days do
      date = @start_date + @space_day.days
      unless date.saturday? || date.sunday?
        @order_states[date] = @station.time_area_settings.dup
        day += 1
      end
      @space_day += 1
    end 
  end

end