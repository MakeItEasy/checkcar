module ApplicationHelper
  def telephone_mask_hash
    { 'data-inputmask' => '"mask": "99999999999", "clearIncomplete": true', 'data-mask' =>'' } 
  end

  ## 转化enum，用于画面显示
  # 返回示例：[['男', '0'], ['女', '1']]
  def enum_list_for_view(codes={}, prefix='' )
    result = []
    codes.each do |key, value|
      result << [I18n.t("enumerize.#{prefix}.#{key}", default: key.to_s), value]
    end
    result
  end

  def render_blank_enable_item(item=nil)
    if item.blank?
      I18n.t('view.label.blank_item_default_show_value').html_safe
    else
      item
    end
  end
end
