class FindProducts
  attr_reader :products

  def initialize(products = initial_scope)
    @products = products
  end

  def call(params = {})
    scoped = products
    # ======FILTROS======
    scoped = filter_by_category(scoped, params[:category_id])
    scoped = filter_by_price(scoped, params[:min_price], params[:max_price])
    scoped = filter_by_query_text(scoped, params[:query_text])
    scoped = filter_by_short(scoped, params[:sort])
    scoped
  end

  private

  def initial_scope
    Product.with_attached_photo
  end

  def filter_by_category(scoped, category_id)
    return scoped unless category_id.present?

    scoped.where(category_id: category_id)
  end

  def filter_by_price(scoped, min_price, max_price)
    # Aplicar filtros
    scoped = scoped.where("price >= ?", min_price.to_f) if min_price.present?
    scoped = scoped.where("price <= ?", max_price.to_f) if max_price.present?

    # Orden dinámico
    if min_price.present? || max_price.present?
      order_direction = (max_price.present? && !min_price.present?) ? :desc : :asc
      scoped = scoped.order(price: order_direction)
    end

    scoped
  end

  def filter_by_query_text(scoped, query_text)
    return scoped unless query_text.present?
    pattern = "%#{query_text}%"
    result = scoped.where(
      "title ILIKE :q OR description ILIKE :q OR price = :p",
      q: pattern,
      p: query_text.to_f
    )
    result
  end

  def filter_by_short(scoped, sort)
    case sort
    when "title_asc"
      scoped.order(title: :asc)
    when "title_desc"
      scoped.order(title: :desc)
    when "price_asc"
      scoped.order(price: :asc)
    when "price_desc"
      scoped.order(price: :desc)
    when "newest"
      scoped.order(created_at: :desc)
    when "oldest"
      scoped.order(created_at: :asc)
    else
      scoped.order(created_at: :desc)
    end
  end
end
