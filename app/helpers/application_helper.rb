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

  ## 渲染问题状态
  def render_question_status(answered)
    if answered
      "<span class='label label-success'>#{I18n.t('view.label.answered')}</span>".html_safe
    else
      "<span class='label label-danger'>#{I18n.t('view.label.wait_answer')}</span>".html_safe
    end
  end

  def i18n_by_prefix_and_controller(prefix)
    scopes = controller.controller_path.split("/")
    scopes.pop
    while scopes.length > 0 && I18n.t("#{prefix}.#{scopes.join('.')}.#{controller.controller_name}", default: "") == "" do
      scopes.pop
    end
    if scopes.present?
      I18n.t("#{prefix}.#{scopes.join('.')}.#{controller.controller_name}")
    else
      I18n.t("#{prefix}.#{controller.controller_name}")
    end
  end

  def i18n_by_prefix_and_action(prefix)
    scopes = controller.controller_path.split("/")
    while scopes.length > 0 && I18n.t("#{prefix}.#{scopes.join('.')}.#{controller.action_name}",
                                      default: "") == "" do
      scopes.pop
    end
    if scopes.present?
      I18n.t("#{prefix}.#{scopes.join('.')}.#{controller.action_name}")
    else
      I18n.t("#{prefix}.#{controller.action_name}")
    end
  end
end
