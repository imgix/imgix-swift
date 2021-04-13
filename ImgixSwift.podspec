Pod::Spec.new do |s|
  s.name = "ImgixSwift"
  s.version = "1.1.3"
  s.summary = "The official imgix Swift client. Written in Swift, but plays nice with Objective-C codebases, too! 👌"

  s.license = { :type => 'BSD 2-Clause', :file => 'LICENSE.md' }
  s.homepage = "https://github.com/imgix/imgix-swift"
  s.authors = { "Paul Straw" => "paulstraw@paulstraw.com", "Sherwin Heydarbeygi" => "sherwin@imgix.com" }
  s.source = { :git => "https://github.com/imgix/imgix-swift.git", :tag => s.version }

  s.requires_arc = true
  s.source_files = ["Sources/ImgixSwift/*.swift"]

  s.swift_versions = ['3.0', '4.0', '5.0']

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.2"
end
