Pod::Spec.new do |s|
  s.name                = 'PodioKit'
  s.version             = '2.0.0'
  s.source              = { :git => 'https://github.com/podio/podio-objc.git', :tag => s.version.to_s }

  s.summary             = "PodioKit is an Objective-C client library for the Podio API."
  s.homepage            = "https://github.com/podio/podio-objc"
  s.license             = 'MIT'
  s.authors             = { "Sebastian Rehnby" => "sebastian@podio.com",
                            "Romain Briche" => "briche@podio.com"}

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.requires_arc          = true

  s.default_subspec = 'Common'

  s.subspec 'Common' do |sp|
    sp.source_files = 'PodioKit/Common/**/*.{h,m}'
    sp.public_header_files = 'PodioKit/Common/**/*.h'
    sp.prefix_header_file  = 'PodioKit/Common/PodioKit-Prefix.pch'
    
    sp.ios.source_files = 'PodioKit/UIKit/**/*.{h,m}'
    sp.ios.public_header_files = 'PodioKit/UIKit/*.h'
    sp.ios.frameworks = 'UIKit'
  end

  s.subspec 'Push' do |sp|
    sp.source_files = 'PodioKit/Push/**/*.{h,m}'
    sp.public_header_files = 'PodioKit/Push/**/*.h'

    sp.dependency 'PodioKit/Common'
    sp.dependency 'DDCometClient',  '~> 1.0'
    sp.dependency 'FXReachability', '~> 1.3'
  end
end
