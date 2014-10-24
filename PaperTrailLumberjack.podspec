Pod::Spec.new do |s|
  s.name             = "PaperTrailLumberjack"
  s.version          = "0.2.0"
  s.summary          = "A CocoaLumberjack logger to post logs to papertrailapp.com"
  s.description      = <<-DESC
A CocoaLumberjack logger to post log messages to papertrailapp.com. Currently, only posts via unsecured UDP sockets.
                       DESC
  s.homepage         = "http://github.com/greenbits/papertrail-lumberjack-ios"
  s.license          = 'MIT'
  s.author           = { "George Malayil Philip" => "george.malayil@roguemonkey.in" }
  s.source = { :git => "https://github.com/greenbits/papertrail-lumberjack-ios.git" , :tag => s.version.to_s }

  s.requires_arc = true
  s.ios.platform = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.osx.platform = :osx, '10.7'
  s.osx.deployment_target = '10.7'

  s.source_files = 'Classes'

  s.dependency 'CocoaLumberjack', '2.0.0-beta3'
  s.dependency 'CocoaAsyncSocket'
end
