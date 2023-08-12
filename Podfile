# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Hi_Dubai' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'ParallaxHeader', '~> 3.0.0'
  pod "SkeletonView"
  pod 'MXParallaxHeader'
  pod 'Parchment', '~> 3.2'
  pod 'CarbonKit'
  pod 'SwiftyJSON', '~> 4.0'
  pod "PromiseKit", "~> 6.8"
  pod 'FirebaseAnalytics'
  pod 'SwiftLint'
  pod 'FontAwesome.swift'
  pod 'IQKeyboardManagerSwift'
  pod 'DGCharts'
  # Pods for Hi_Dubai
  
end


post_install do |installer|

  installer.generated_projects.each do |project|
    project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
            end
        end
    end
end
