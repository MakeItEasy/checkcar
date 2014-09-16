namespace :car do
  namespace :order do

    desc "处理过期预约, 自动将状态改为checked"
    task :process_expired => [:environment] do
      orders = Order.success.expired_for_auto_process.all
      total = orders.count
      success = 0
      fail_ids = []
      orders.each do |item|
        # 自动将状态改为已检车
        if item.update_attribute(:status, :checked)
          success += 1
        else
          fail_ids << item.id
        end
      end
      Rails.logger.info "处理结果"
      Rails.logger.info "抽出: #{total}件"
      Rails.logger.info "成功: #{success}件"
      Rails.logger.info "失败: #{fail_ids.count}件"
      if fail_ids.present?
        Rails.logger.info "失败Record: #{fail_ids}"
      end
    end

    desc "echo test"
    task :echo => :environment do
      Rails.logger.info "info test"
      puts "completed"
    end
  end
end

# 如何使用参数
# task :expired, [:text, :name] => [:pre, :environment] do |t, args|
# rake "expired[text value, name value]" to invoke this task
