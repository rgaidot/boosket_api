require 'rubygems'
require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rake/gempackagetask'
require 'find'

require File.expand_path('../lib/boosket_api/version', __FILE__)

PKGNAME = 'boosket_api'
PKGVERSION = version = File.read("BOOSKET_API_VERSION").strip

PKGFILES = [ 'Rakefile' ]
Find.find('init.rb', 'lib/', 'test/', 'rails/') do |f|
  if FileTest.directory?(f) and f =~ /\.svn/
    Find.prune
  else
    PKGFILES << f
  end
end

PKGFILES.reject! { |f| f =~ /^test\/(fixtures|.*_output)\// }

desc 'Default: run unit tests'
task :default => [:test]

desc 'Create gemspec file'
task :gemspec do
  spec = Gem::Specification.new do |s|
    s.platform = Gem::Platform::RUBY
    s.author = 'Regis Gaidot'
    s.email = 'regis.gaidot@boosket.com'
    s.homepage = 'http://github.com/rgaidot/boosket_api'
    s.summary = "Boosket API"
    s.name = PKGNAME
    s.rubyforge_project = PKGNAME
    s.version = PKGVERSION
    s.require_path = 'lib'
    s.has_rdoc = true
    s.extra_rdoc_files = ['README.rdoc']
    s.rdoc_options << '--line-numbers' << '--inline-source' << 'README.rdoc'
    s.files = PKGFILES
    s.description = File.read('README.rdoc')
  end
  File.open("#{spec.name}.gemspec", "w") do |f|
    f.write spec.to_ruby
  end
end

desc 'Build the gem'
task :install => :gemspec do
  system "gem build boosket_api.gemspec"
end

desc 'Build the gem'
task :release => :install do
  system "git commit -m \"#{PKGVERSION}\""
  system "git push origin master"
  system "gem push boosket_api-#{PKGVERSION}.gem"
end

desc 'Clean Up'
task :clean do |t|
  FileUtils.rm_rf "doc"
  FileUtils.rm_rf "pkg"
end

desc 'Generate documentation for the boosket_api plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "doc"
  rdoc.title    = "Boosket API"
  rdoc.options << '--line-numbers' << '--inline-source' 
  rdoc.options << '--charset' << 'utf-8'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*', 'LICENSE')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Package boosket_api plugin.'
Rake::PackageTask.new(PKGNAME, PKGVERSION) do |p| 
  p.need_tar = true
  p.need_zip = true
  p.package_files = PKGFILES
end

desc 'Test the boosket_api plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
