# == Schema Information
#
# Table name: conventions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module ConventionsHelper
  def filter_by_convention
    select_tag 'convention',
               options_for_select([['All', 'all']]) +
                   options_from_collection_for_select(Convention.order('start_date desc'), 'id', 'name',
                                                      params[:convention] ||
                                                          lambda { |c| Convention.order('start_date desc').first.id == c.id }),
               class: 'convention-filter form-control input-sm' unless Convention.count == 0
  end
end
