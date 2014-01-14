platform :ios, '5.0'

target :podiokit do
  link_with 'PodioKit'
  
  pod 'AFNetworking', '1.3.3'
end

target :podiokittests do
  link_with 'PodioKitTests'
  
  pod 'AFNetworking', '1.3.3'
  
  pod 'OHHTTPStubs'
  pod 'Expecta'
  pod 'OCMock'
end

target :demoapp do
  link_with 'DemoApp'
  
  pod 'PodioKit', :path => '.'
end