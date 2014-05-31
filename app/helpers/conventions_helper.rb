module ConventionsHelper
  def filter_by_convention
    select_tag 'convention',
               options_for_select([['All', 'all']]) +
               options_from_collection_for_select(Convention.order('start_date desc'), 'id', 'name',
                                                  params[:convention] ||
                                                      lambda { |c| Convention.order('start_date desc').first.id == c.id }),
               class: 'convention-filter small' unless Convention.count == 0
  end
end
