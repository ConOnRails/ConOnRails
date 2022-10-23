# frozen_string_literal: true

module ConventionsHelper
  def filter_by_convention # rubocop:disable Metrics/MethodLength
    return if Convention.count.zero?

    select_tag 'convention',
               options_for_select([%w[All all]]) +
               options_from_collection_for_select(Convention.order('start_date desc'),
                                                  'id', 'name',
                                                  params[:convention] ||
                                                      lambda { |c|
                                                        Convention.order('start_date desc')
                                                                  .first.id == c.id
                                                      }),
               class: 'convention-filter form-control input-sm'
  end
end
