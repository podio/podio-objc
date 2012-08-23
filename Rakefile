# do not echo sh commands
verbose(false)

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
        --project-company \"Citrix Systems, Inc.\" \
        --company-id com.podio \
        --output Docs PodioKit"
  end
end