#
# Be sure to run `pod lib lint MMRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MMPopMenu'
  s.version          = '0.0.1'
  s.summary          = 'MMURLRouter is a small pop animation.'
  s.description      = <<-DESC
    MMURLRouter is a small pop animation,you can use it more easier
    DESC
  s.homepage         = 'https://github.com/IDwangluting/MMPopMenu'
  s.license          = "Copyright (c) 2018年 wangluitng. All rights reserved."
  s.author           = { 'IDwangluting' => 'm13051699286@163.com' }
  s.source           = { :git => 'https://github.com/IDwangluting/MMPopMenu.git', :tag => s.version.to_s }
  
  s.ios.deployment_target   = '8.0'
  s.source_files            = 'MMPopMenu/Classes/**/*'
  s.frameworks              = 'UIKit'
end




