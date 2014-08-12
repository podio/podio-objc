Pod::Spec.new do |s|
  s.name                = 'PodioKit'
  s.version             = '2.0.0-beta5'
  s.source              = { :git => 'https://github.com/podio/podio-objc.git', :tag => s.version.to_s }

  s.summary             = "PodioKit is an Objective-C client library for the Podio API."
  s.homepage            = "https://github.com/podio/podio-objc"
  s.license             = 'MIT'
  s.authors             = { "Sebastian Rehnby" => "sebastian@podio.com",
                            "Romain Briche" => "briche@podio.com"}

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.requires_arc          = true

  s.source_files        = 'PodioKit/Common/**/*.{h,m}'
  s.public_header_files = 'PodioKit/Common/**/*.h'
  s.prefix_header_file  = 'PodioKit/Common/PodioKit-Prefix.pch'

  s.ios.source_files = 'PodioKit/UIKit/**/*.{h,m}'
  s.ios.public_header_files = 'PodioKit/UIKit/*.h'
  s.ios.frameworks = 'UIKit'
end
