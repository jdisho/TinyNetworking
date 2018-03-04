Pod::Spec.new do |spec|
  spec.name         = 'TinyNetworking'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/jdisho/TinyNetworking'
  spec.authors      = { 'Joan Disho' => 'dishojoan@gmail.com' }
  spec.summary      = 'Simple network layer written in Swift.'
  spec.source       = { :git => 'https://github.com/jdisho/TinyNetworking.git', :tag => '#{s.version}' }
  spec.source_files = 'TinyNetworking/*.swift'
  spec.platform     = :ios, '10.0'
  spec.dependency 'RxSwift', '~> 4.0'
end