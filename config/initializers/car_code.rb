## 主要用于enum
module Car
  module Code
    POST_STATUS = {
      # 草稿
      draft: '00',
      # 等待审核
      waiting: '01',
      # 发布(审核通过)
      published: '02',
      # 审核拒绝
      rejected: '03',
      # 锁定
      locked: '04' 
    }

    STATION_STATUS = {
      # 等待审核
      waiting: '00',
      # 审核通过
      reviewed: '01',
      # 审核拒绝
      rejected: '02',
      # 锁定
      locked: '03' 
    }

    ORDER_STATUS = {
      # 预约成功
      success: '00',
      # 取消
      cancel: '01',
      # 已经检车
      checked: '02',
      # 没来检车,爽约
      missit: '03'
    }

    SEX = {
      male: '0',
      female: '1'
    }

    LOGIN_TYPE = {
      email: 'email',
      telephone: 'telephone'
    }

    # 系统管理员角色
    SYSTEM_ROLES = ["superadmin", "moderator", "editor"]

    # 车检站管理员角色
    STATION_ROLES = ["admin", "normal"]

    # 车检站管理员角色
    CAR_NUMBER_AREA = ["陕", "京"]

  end
end
