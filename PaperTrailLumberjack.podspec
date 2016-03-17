Pod::Spec.new do |s|
  s.name             = "PaperTrailLumberjack"
  s.version          = "2.0.0"
  s.summary          = "A CocoaLumberjack logger to post logs to papertrailapp.com"
  s.description      = <<-DESC
A CocoaLumberjack logger to post log messages to papertrailapp.com. Currently, only posts via unsecured UDP sockets.
                       DESC
  s.homepage         = "http://github.com/greenbits/papertrail-lumberjack-ios"
  s.license          = 'MIT'
  s.author           = { "George Malayil Philip" => "george.malayil@roguemonkey.in" }
  s.source = { :git => "https://github.com/greenbits/papertrail-lumberjack-ios.git" , :tag => s.version.to_s }
  s.platform         = :ios

  s.requires_arc = true
  s.ios.deployment_target = '5.0'

  s.source_files = 'Classes'

  s.dependency 'CocoaLumberjack', '~> 2.2.0'
  s.dependency 'CocoaAsyncSocket'
end
