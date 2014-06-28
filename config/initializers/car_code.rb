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

    SEX = {
      male: '0',
      female: '1'
    }
  end
end
