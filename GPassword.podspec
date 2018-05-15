Pod::Spec.new do |s|
  s.name         = "GPassword"
  s.version      = "1.0.1"
  s.summary      = "Simple gesture password in swift."
  s.description  = <<-DESC
  This framework help you build your gesture password easily!
                   DESC
  s.homepage     = "https://github.com/hackjie/GPassword"
  s.license      = "MIT"
  s.author       = { "leoli" => "codelijie@gmail.com" }
  s.source       = { :git => "https://github.com/hackjie/GPassword.git", :tag => "#{s.version}" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  #  When using multiple platforms
  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source_files  = "Source/**/*.swift"
  # s.public_header_files = "Classes/**/*.h"

end
