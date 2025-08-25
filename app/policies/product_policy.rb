class ProductPolicy < BasePolicy
  def edit; allowed?; end
  def update; allowed?; end
  def destroy; allowed?; end

  private

  def allowed?
    Current.user&.admin? || record.owner?
  end
end
