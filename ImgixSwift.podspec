Pod::Spec.new do |s|
  s.name = "ImgixSwift"
  s.version = "0.1.0"
  s.summary = "The official imgix Swift client. Written in Swift, but plays nice with Objective-C codebases, too! 👌"

  s.license = { :type => 'BSD 2-Clause', :file => 'LICENSE.md' }
  s.homepage = "https://github.com/imgix/imgix-swift"
  s.authors = { "Paul Straw" => "paulstraw@paulstraw.com" }
  s.source = { :git => "https://github.com/imgix/imgix-swift.git", :tag => s.version }

  s.requires_arc = true
  s.source_files = ["Sources/*.swift", "Sources/**/*.swift", "Sources/ImgixSwift-Bridging-Header.h"]

  s.xcconfig = {
    # "SWIFT_OBJC_BRIDGING_HEADER" => "Sources/ImgixSwift-Bridging-Header.h",
    "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => true
    # "SWIFT_INCLUDE_PATHS" => "$(SRCROOT)/imgix-swift/CommonCrypto"
  }
  # s.preserve_paths = ["CommonCrypto/*"]
  # s.preserve_path = "CommonCrypto/*"
  # s.module_map = "CommonCrypto/module.map"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.2"
end
