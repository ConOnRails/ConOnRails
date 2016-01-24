namespace :sections do
  desc "Create CONvergence sections from old event flags"
  # Before sections, we had hard-wired boolean flags representing
  # the departments we logged events for. Now, we have sections, and
  # in theory, anyone with the right permissions can log for a given
  # section (or more than one section at once), so the hard-wired flags
  # can go away; but for CVG, we still need at least those sections
  # defined, for legacy porpoises.
  #
  # If you're not CONvergence, you can ignore this if you like, and
  # just create your own sections from the UI.
  #
  task :create_cvg_sections => :environment do
    DEPT_FLAGS = %w[ consuite hotel parties volunteers dealers dock merchandise nerf_herders ]

    DEPT_FLAGS.each do |f|
      Section.find_or_create_by! name: f.humanize.capitalize
    end

  end

end