Pod::Spec.new do |s|
  s.name     = 'TBannerView'
  s.version  = '1.0'
  s.license  =  { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'A component to display banners (e.g. adverts).'
  s.homepage = 'https://github.com/Tulakshana/TBannerView'
  s.author   = 'Tulakshana Asanka Weerasooriya'
  s.source   = { :git => 'https://github.com/Tulakshana/TBannerView.git', :tag => s.version.to_s }
  s.platform = :ios, '8.1'

  s.source_files = 'TBannerView/**/*.{h,m}'
  s.requires_arc = true
  s.dependency 'SDWebImage', '~> 3.7.1'
end
