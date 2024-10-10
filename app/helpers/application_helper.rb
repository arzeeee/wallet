module ApplicationHelper
  def flash_class(level)
    case level
    when "success" then "ui green message"
    when "alert" then "ui red message"
    when "notice" then "ui blue message"
    end
  end

  def paginate(scope, params)
    collection = Kaminari.paginate_array(scope).page(params[:page] || 1).per(params[:per_page] || 10)
    current, total, per_page = collection.current_page, collection.total_pages, collection.limit_value

    {
      pagination: {
        current:  current,
        previous: (current > 1 ? (current - 1) : nil),
        next:     (current == total ? nil : (current + 1)),
        per_page: per_page,
        last_page: total,
        count:    collection.total_count
      },
      data: collection
    }
  end
end
