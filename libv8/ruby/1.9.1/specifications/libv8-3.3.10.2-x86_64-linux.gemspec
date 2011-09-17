# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "libv8"
  s.version = "3.3.10.2"
  s.platform = "x86_64-linux"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Logan Lowell", "Charles Lowell"]
  s.date = "2011-05-31"
  s.description = "Distributes the V8 JavaScript engine in binary and source forms in order to support fast builds of The Ruby Racer"
  s.email = ["fractaloop@thefrontside.net", "cowboyd@thefrontside.net"]
  s.homepage = "http://github.com/fractaloop/libv8"
  s.require_paths = ["lib"]
  s.rubyforge_project = "libv8"
  s.rubygems_version = "1.8.10"
  s.summary = "Distribution of the V8 JavaScript engine"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
    else
      s.add_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_dependency(%q<bundler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, ["~> 0.8.7"])
    s.add_dependency(%q<bundler>, [">= 0"])
  end
end
