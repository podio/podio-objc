platform :ios, '7.0'

target :podiokit do
  link_with 'PodioKit'
  
  pod 'AFNetworking', '~> 2.0'
end

target :podiokittests do
  link_with 'PodioKitTests'
  
  pod 'AFNetworking', '~> 2.0'
  
  pod 'OHHTTPStubs'
  pod 'Expecta'
  pod 'OCMock'
end

target :demoapp do
  link_with 'DemoApp'
  
  pod 'PodioKit', :path => '.'
end