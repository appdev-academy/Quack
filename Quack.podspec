Pod::Spec.new do |s|
  s.name             = "Quack"
  s.version          = "0.3.2"
  s.summary          = "Quack will help you to utilize alerts, notifications and progress HUDs inside your iOS app"
  s.homepage         = "https://github.com/appdev-academy/Quack"
  s.license          = 'MIT'
  s.author           = { "Maksym Skliarov" => "maksym@appdev.academy" }
  s.source           = { :git => "https://github.com/appdev-academy/Quack.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AppDev_Academy'
  
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.swift_version = '5.0'
  
  s.source_files = 'Quack/Classes/**/*'
  s.frameworks = 'UIKit'
  s.requires_arc = true
end
