Pod::Spec.new do |spec|
  spec.name         = 'TinyNetworking'
  spec.version      = '0.2.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/jdisho/TinyNetworking'
  spec.authors      = { 'Joan Disho' => 'dishojoan@gmail.com' }
  spec.summary      = 'Simple network layer written in Swift.'
  spec.source       = { :git => 'https://github.com/jdisho/TinyNetworking.git', :tag => spec.version }
  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.10'
  spec.watchos.deployment_target = '2.0'
  spec.tvos.deployment_target = '9.0'
  spec.default_subspec = 'Core'

   spec.subspec 'Core' do |ss|
    ss.source_files = 'Sources/TinyNetworking/*.swift'
    ss.framework  = 'Foundation'
  end

   spec.subspec 'RxSwift' do |ss|
    ss.source_files = 'Sources/RxTinyNetworking/*.swift'
    ss.dependency 'TinyNetworking/Core'
    ss.dependency 'RxSwift', '~> 4.0'
  end
end