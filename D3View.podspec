Pod::Spec.new do |s|
  s.name             = 'D3View'
  s.version          = '0.0.3'
  s.license          = { :type => "MIT", :file => 'LICENSE' }
  s.homepage         = 'https://github.com/mozhenhau/D3View'
  s.authors          = {"mozhenhau" => "493842062@qq.com"}
  s.summary          = 'D3View, ui util'
  s.source           =  {:git => 'https://github.com/mozhenhau/D3View.git', :tag => '0.0.3' }
  s.source_files     = 'D3View/D3View/*.{h,m,swift}'
  s.requires_arc     = true
  s.ios.deployment_target = '8.0'
end


