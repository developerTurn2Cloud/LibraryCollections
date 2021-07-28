Pod::Spec.new do |spec|
  spec.name         = "LibraryCollections"
  spec.version      = "1.2.4"
  spec.summary      = "Common Library"
  spec.description  = "LibraryCollections is a library for common usage."
  spec.homepage     = "https://github.com/YomiRY/LibraryCollections"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Randy" => "o1984531@gmail.com" }
  spec.platform     = :ios, "11.0"
  spec.ios.deployment_target = '11.0'
  spec.source       = { :git => "https://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@github.com/YomiRY/LibraryCollections.git", :tag => "1.2.4" }
  spec.source_files  = "LibraryCollections", "LibraryCollections/**/*.{gif,jpg,pdf,png,h,m,swift}"
  spec.resources = "LibraryCollections/**/*.xib"
  spec.swift_versions = ['5.1', '5.2', '5.3']
  spec.static_framework = true
  spec.frameworks = [
    'Foundation',
    'UIKit',
    'QuartzCore',
    'CoreText', 
    'CoreGraphics',
    'AVFoundation',
    'WebKit'
]

  #spec.resource_bundles = {'AssetsBundle' => ['LibraryCollections/**/*.xcassets']}

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "UIKit"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  spec.dependency "Toast-Swift", "~> 5.0.1"
  spec.dependency "Moya/RxSwift", "~> 13.0"
  spec.dependency 'RxCocoa'
  spec.dependency "Kingfisher", "~> 5.0"
  spec.dependency 'Firebase/Performance'
  spec.dependency 'Firebase/Crashlytics'
  spec.dependency "Firebase/Analytics"
  spec.dependency "Firebase/InAppMessaging"
  spec.dependency "Firebase/Messaging"
  spec.dependency "IQKeyboardManagerSwift"
  spec.dependency "SwiftEventBus"
  spec.dependency 'ActionSheetPicker-3.0'
  spec.dependency 'Batch', '~> 1.15'
  spec.dependency 'Device', '~> 3.2.1'

  spec.xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(PODS_ROOT)/Firebase/CoreOnly/Sources' }
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
