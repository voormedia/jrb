# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jrb}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rolf Timmermans"]
  s.date = %q{2011-03-23}
  s.description = %q{JRB is a collection of utilities to use Ruby code as templates. It provides a set of optional helpers that allow you to build output efficiently. A Rails adapter is included.}
  s.email = %q{r.timmermans@voormedia.com}
  s.homepage = %q{http://rails-erd.rubyforge.org/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{jrb}
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{JRB templates are Just Ruby.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<activerecord>, ["~> 3.0"])
    else
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<activerecord>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<activerecord>, ["~> 3.0"])
  end
end

