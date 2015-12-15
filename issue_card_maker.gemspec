# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = 'issue_card_maker'
  spec.version       = '1.0'
  spec.authors       = ['Benjamin Ragheb', 'Jimmy Pendry']
  spec.email         = ['ben@logcheck.com', 'jimmy@logcheck.com']
  spec.summary       = %q{TO-DO: Write a short summary. Required.}
  spec.description   = %q{TO-DO: Write a longer description. Optional.}
  spec.homepage      = ''
  spec.license       = 'GPL'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^test/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.4'

  spec.add_dependency 'netrc', '~> 0.11'
  spec.add_dependency 'octokit', '~> 4.2'
  spec.add_dependency 'ruby-trello', '~> 1.3'

  spec.add_self_to_load_path
end
