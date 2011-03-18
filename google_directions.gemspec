# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{google_directions_waypoints}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ['Josh Crews', 'Thomas Wolfe']
  s.date = %q{2011-03-17}
  s.description = %q{Ruby-wrapper for Google Directions API.  Can return the drive time and driving distance between several places}
  s.email = ['josh@joshcrews.com', 'tomwolfe@gmail.com']
  s.extra_rdoc_files = ["README.textile", "lib/google_directions.rb"]
  s.files = ["Manifest", "README.textile", "Rakefile", "google_directions.gemspec", "init.rb", "lib/google_directions.rb", "test/mocks/google_directions_samle_xml.xml", "test/test_helper.rb", "test/unit/google_directions_test.rb"]
  s.homepage = %q{https://github.com/tomwolfe/google-directions-ruby}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Google_directions", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.summary = %q{Ruby-wrapper for Google Directions API.}
  s.test_files = ["test/test_helper.rb", "test/unit/google_directions_test.rb"]
  s.add_dependency(%q<nokogiri>, [">= 1.4.1"])
end
