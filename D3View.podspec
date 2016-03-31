Pod::Spec.new do |s|
  s.name             = 'D3View'
  s.version          = '1.2.0'
  s.license          = { :type => "MIT", :file => 'LICENSE' }
  s.homepage         = 'https://github.com/mozhenhau/D3View'
  s.authors          = {"mozhenhau" => "493842062@qq.com"}
  s.summary          = 'D3View, a simple way to animate'
  s.source           =  {:git => 'https://github.com/mozhenhau/D3View.git', :tag => '1.2.0' }
  s.source_files     = 'D3View/D3View/*.{swift}'
  s.requires_arc     = true
  s.ios.deployment_target = '8.0'
end


