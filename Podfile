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
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
    end
  end
end
