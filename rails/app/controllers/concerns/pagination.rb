module Pagination
  extend ActiveSupport::Concern

  def pagination(records)
    {
      current_page: records.current_page, # 現在のページ数
      total_pages: records.total_pages, # 総ページ数
    }
  end
end
