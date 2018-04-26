Pod::Spec.new do |s|
  s.name         = "GPassword"
  s.version      = "0.0.1"
  s.summary      = "Simple gesture password in swift."
  s.description  = <<-DESC
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

  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  s.source_files  = "Source/*.swift"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

end
