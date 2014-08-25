platform :ios, '5.0'

target :podiokit do
  link_with 'PodioKit'
  
  pod 'AFNetworking', '~> 1.3'
end

target :podiokittests do
  link_with 'PodioKitTests'
  
  pod 'PodioKit', :path => '.'
  
  pod 'OHHTTPStubs', '1.1.1'
end

target :demoapp do
  link_with 'DemoApp'
  
  pod 'PodioKit', :path => '.'
end