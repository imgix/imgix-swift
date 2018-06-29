desc 'Run the tests'
task :test do
  require_binary 'xcodebuild', 'brew install xcodebuild'
  require_binary 'xcpretty', 'bundle install'
  sh 'xcodebuild test -project imgix-swift.xcodeproj -scheme ImgixSwift-iOS -destination \'OS=10.0,name=iPhone 6\' -sdk \'iphonesimulator\' -configuration Debug ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=YES | bundle exec xcpretty --color; exit ${PIPESTATUS[0]}'
end

task :default => :test

private

def require_binary(binary, install)
  if `which #{binary}`.length == 0
    fail "\nERROR: #{binary} isn't installed. Please install #{binary} with the following command:\n\n    $ #{install}\n\n"
  end
end
