require 'rdoc/task'

Rake::RDocTask.new do |rdoc|
	rdoc.rdoc_files.include('README.md')
	rdoc.rdoc_files.include("app/*/*.rb")
	rdoc.main = "README.md"	#start page
	rdoc.title = "Project Sabertooth Documentation"
	rdoc.rdoc_dir = 'rdoc'
end
