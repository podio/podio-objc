# do not echo sh commands
verbose(false)

SCRIPTS = './Scripts'

desc "Run the PodioKit unit test suite"
task :test => 'test:run'

namespace :test do
  task :run do
    sh "#{SCRIPTS}/run-tests"
  end
  
  desc "Generate a coverage report from the last test run"
  task :coverage do
    opts = ''
    opts << " --publish #{ENV['publish']}" if ENV['publish']
    
    sh "#{SCRIPTS}/coverage-report#{opts}"
  end
end

namespace :docs do
  desc "Generate PodioKit documentation using appledoc"
  task :generate do
    sh "appledoc \
        --create-html \
        --create-docset \
        --install-docset \
        --clean-output \
        --keep-intermediate-files \
        --project-name PodioKit \
        --project-company \"Citrix Systems, Inc\" \
        --company-id com.podio \
        --output Docs PodioKit"
  end
end