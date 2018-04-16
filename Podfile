# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'BullsEye' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BullsEye
  pod 'Alamofire', '~> 4.7'

  target 'Tests' do
    inherit! :search_paths
    pod 'Quick', '~> 1.2.0'
    pod 'Nimble', '~> 7.0.3'
    pod 'OHHTTPStubs/Swift', '~> 6.1.0'
  end

  target 'UITests' do
    inherit! :search_paths
    pod 'Quick', '~> 1.2.0'
    pod 'Nimble', '~> 7.0.3'
    pod 'Swifter', '~> 1.3.3'
  end

end

post_install do |installer|
    swift_32 = ['Swifter']

    installer.pods_project.targets.each do |target|
        if swift_32.include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
end
