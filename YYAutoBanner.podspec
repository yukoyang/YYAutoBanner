Pod::Spec.new do |s|
  s.name             = "YYAutoBanner"
  s.version          = "1.0.0"
  s.summary          = "A autoBanner view used on iOS."
  s.description      = <<-DESC
                       It is a autoBanner view used on iOS, which implement by swift.
                       DESC
  s.homepage         = "https://github.com/yukoyang/YYAutoBanner"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "杨颖" => "yangying514@sohu.com" }
  s.source           = { :git => "https://github.com/wangzz/WZMarqueeView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/NAME'

  s.platform     = :ios, '8.0'
  # s.ios.deployment_target = '8.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'WZMarqueeView/*'
  # s.resources = 'Assets'

  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

end
