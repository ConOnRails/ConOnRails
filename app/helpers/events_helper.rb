module EventsHelper
  def filter(term)
    params[:filters][term].presence if params[:filters].present?
  end
end
