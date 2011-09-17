# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ansi"
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Thomas Sawyer", "Florian Frank"]
  s.date = "2011-06-30"
  s.description = "The ANSI project is a collection of ANSI escape code related libraries enabling ANSI code based colorization and stylization of output. It is very nice for beautifying shell output."
  s.email = "rubyworks-mailinglist@googlegroups.com"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc"]
  s.homepage = "http://rubyworks.github.com/ansi"
  s.licenses = ["Apache 2.0"]
  s.rdoc_options = ["--title", "ANSI API", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "ansi"
  s.rubygems_version = "1.8.10"
  s.summary = "ANSI codes at your fingertips!"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<detroit>, [">= 0"])
      s.add_development_dependency(%q<qed>, [">= 0"])
      s.add_development_dependency(%q<lemon>, [">= 0"])
    else
      s.add_dependency(%q<detroit>, [">= 0"])
      s.add_dependency(%q<qed>, [">= 0"])
      s.add_dependency(%q<lemon>, [">= 0"])
    end
  else
    s.add_dependency(%q<detroit>, [">= 0"])
    s.add_dependency(%q<qed>, [">= 0"])
    s.add_dependency(%q<lemon>, [">= 0"])
  end
end
