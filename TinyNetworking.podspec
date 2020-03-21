Pod::Spec.new do |spec|
  spec.name         = 'TinyNetworking'
  spec.version      = '4.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/jdisho/TinyNetworking'
  spec.authors      = { 'Joan Disho' => 'dishojoan@gmail.com' }
  spec.summary      = 'Simple network layer written in Swift.'
  spec.source       = { :git => 'https://github.com/jdisho/TinyNetworking.git', :tag => spec.version }
  spec.swift_version = '5.1'
  spec.cocoapods_version = '>= 1.4.0'  
  spec.ios.deployment_target = '10.0'
  spec.osx.deployment_target = '10.12'
  spec.watchos.deployment_target = '3.0'
  spec.tvos.deployment_target = '10.0'
  spec.default_subspec = 'Core'

   spec.subspec 'Core' do |ss|
    ss.source_files = 'Sources/TinyNetworking/*.swift'
    ss.framework  = ['Foundation', 'Combine']
  end

   spec.subspec 'RxSwift' do |ss|
    ss.source_files = 'Sources/RxTinyNetworking/*.swift'
    ss.dependency 'TinyNetworking/Core'
    ss.dependency 'RxSwift', '~> 5.0'
  end
end
