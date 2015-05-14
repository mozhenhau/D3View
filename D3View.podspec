Pod::Spec.new do |s|
  s.name             = 'D3View'
  s.version          = '0.0.1'
  s.license          = 'MIT'
  s.homepage         = 'https://github.com/mozhenhau/D3View'
  s.authors          = {"mozhenhau" => "493842062@qq.com"}
  s.summary          = 'D3View, ui util'
  s.source           =  {:git => 'https://github.com/mozhenhau/D3View.git', :tag => '0.0.1' }
  s.source_files     = 'D3View/*.{h,m,swift}'
  s.requires_arc     = true

  s.subspec 'MJExtension' do |ss|
    ss.source_files = 'D3View/MJExtension/*'
  end


  s.subspec 'PullRefresh' do |ss|
    ss.source_files = 'D3View/PullRefresh/*'
  end

end


