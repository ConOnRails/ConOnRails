# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "turn"
  s.version = "0.8.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Pease"]
  s.date = "2011-03-31"
  s.description = "TURN is a new way to view Test::Unit results. With longer running tests, it\ncan be very frustrating to see a failure (....F...) and then have to wait till\nall the tests finish before you can see what the exact failure was. TURN\ndisplays each test on a separate line with failures being displayed\nimmediately instead of at the end of the tests.\n  \nIf you have the 'ansi' gem installed, then TURN output will be displayed in\nwonderful technicolor (but only if your terminal supports ANSI color codes).\nWell, the only colors are green and red, but that is still color."
  s.email = "tim.pease@gmail.com"
  s.executables = ["turn"]
  s.extra_rdoc_files = ["History.txt", "README.txt", "Release.txt", "Version.txt", "bin/turn"]
  s.files = ["bin/turn", "History.txt", "README.txt", "Release.txt", "Version.txt"]
  s.homepage = "http://gemcutter.org/gems/turn"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "turn"
  s.rubygems_version = "1.8.10"
  s.summary = "Test::Unit Reporter (New) -- new output format for Test::Unit"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ansi>, [">= 1.2.2"])
      s.add_development_dependency(%q<bones-git>, [">= 1.2.4"])
      s.add_development_dependency(%q<bones>, [">= 3.6.5"])
    else
      s.add_dependency(%q<ansi>, [">= 1.2.2"])
      s.add_dependency(%q<bones-git>, [">= 1.2.4"])
      s.add_dependency(%q<bones>, [">= 3.6.5"])
    end
  else
    s.add_dependency(%q<ansi>, [">= 1.2.2"])
    s.add_dependency(%q<bones-git>, [">= 1.2.4"])
    s.add_dependency(%q<bones>, [">= 3.6.5"])
  end
end
