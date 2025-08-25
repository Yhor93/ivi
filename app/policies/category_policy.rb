class CategoryPolicy < BasePolicy
  def index; allowed?; end
  def new; allowed?; end
  def create; allowed?; end
  def edit; allowed?; end
  def update; allowed?; end
  def destroy; allowed?; end

  private

  def allowed?
    Current.user&.admin?
  end
end
