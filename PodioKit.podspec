Pod::Spec.new do |s|
  s.name                = 'PodioKit'
  s.version             = '2.0.0-beta3'
  s.source              = { :git => 'https://github.com/podio/podio-objc.git', :tag => s.version.to_s }

  s.summary             = "PodioKit is an Objective-C client library for the Podio API."
  s.homepage            = "https://github.com/podio/podio-objc"
  s.license             = 'MIT'
  s.authors             = { "Sebastian Rehnby" => "sebastian@podio.com",
                            "Romain Briche" => "briche@podio.com"}

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'
  s.requires_arc        = true

  s.subspec 'Common' do |ss|
    ss.dependency 'AFNetworking', '~> 2.0'

    ss.source_files        = 'PodioKit/Common/**/*.{h,m}'
    ss.public_header_files = 'PodioKit/Common/**/*.h'
    ss.prefix_header_file  = 'PodioKit/Common/PodioKit-Prefix.pch'
  end

  s.subspec 'UIKit' do |ss|
    ss.dependency 'PodioKit/Common'
    
    ss.ios.deployment_target = '6.0'
    ss.frameworks = 'UIKit'

    ss.ios.source_files = 'PodioKit/UIKit/**/*.{h,m}'
    ss.ios.public_header_files = 'PodioKit/UIKit/*.h'
  end
end
