platform :ios, '8.0'
use_frameworks!
 
target 'NewProduct' do
 
pod 'RxCocoa', '~> 3.0.0'
#pod 'RxSwift', '~> 4.0.1'
pod 'Moya-ModelMapper/RxSwift', '~> 4.1.0'
pod 'RxOptional'
 
end
 
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
              config.build_settings['ENABLE_TESTABILITY'] = 'YES'
              config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
