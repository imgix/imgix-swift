Pod::Spec.new do |s|
  s.name = "ImgixSwift"
  s.version = "0.4.1"
  s.summary = "The official imgix Swift client. Written in Swift, but plays nice with Objective-C codebases, too! 👌"

  s.license = { :type => 'BSD 2-Clause', :file => 'LICENSE.md' }
  s.homepage = "https://github.com/imgix/imgix-swift"
  s.authors = { "Paul Straw" => "paulstraw@paulstraw.com" }
  s.source = { :git => "https://github.com/imgix/imgix-swift.git", :tag => s.version }

  s.xcconfig = {
    "SWIFT_OBJC_INTERFACE_HEADER_NAME" => "ImgixSwift.h"
  }

  s.requires_arc = true
  s.source_files = ["Sources/*.{h,m,swift}"]

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.2"
end
