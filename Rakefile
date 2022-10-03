desc 'Run the tests'
task :test do
  require_binary 'xcodebuild', 'brew install xcodebuild'
  require_binary 'xcpretty', 'bundle install'
  sh '''
    xcodebuild test \
      -project imgix-swift.xcodeproj \
      -scheme ImgixSwift-iOS \
      -destination \'OS=14.5,name=iPhone 11\' \
      -sdk \'iphonesimulator\' \
      -configuration Debug ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=YES | bundle exec xcpretty --color; exit ${PIPESTATUS[0]}
  '''
  sh '''
    xcodebuild test \
    -project imgix-swift.xcodeproj \
    -scheme ImgixSwift-macOS \
    -destination \'platform=OS X,arch=x86_64\' \
    -configuration Debug ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=YES | bundle exec xcpretty --color; exit ${PIPESTATUS[0]}
  '''
  sh '''
    xcodebuild test \
    -project imgix-swift.xcodeproj \
    -scheme ImgixSwift-tvOS \
    -destination \'OS=14.3,name=Apple TV\' \
    -configuration Debug ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=YES | bundle exec xcpretty --color; exit ${PIPESTATUS[0]}
  '''
end

task :default => :test

private

def require_binary(binary, install)
  if `which #{binary}`.length == 0
    fail "\nERROR: #{binary} isn't installed. Please install #{binary} with the following command:\n\n    $ #{install}\n\n"
  end
end
