require_relative 'lib/version'

Gem::Specification.new do |s|
  s.name        = 'capistrano-the-best-compression'
  s.version     = CapistranoTheBestCompression::VERSION
  s.date        = '2016-12-02'
  s.authors     = ['SumatoSoft']
  s.summary     = 'Capistrano the Best Compression'
  s.description = 'Capistrano the best compression gem'

  s.files       = Dir['{lib}/**/*'] + ['README.rdoc', 'Rakefile']
  s.license     = 'MIT'
end
