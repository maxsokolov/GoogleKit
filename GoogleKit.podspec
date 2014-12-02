Pod::Spec.new do |s|
  s.name                  = "GoogleKit"
  s.version               = "0.3.1"
  s.summary               = "An objective-c wrapper around the various Google API's"
  s.homepage              = "https://github.com/maxsokolov/GoogleKit"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.authors               = { "Max Sokolov" => "i@maxsokolov.net" }
  s.social_media_url      = "https://twitter.com/max_sokolov"
  s.platform              = :ios, "7.0"
  s.source                = { :git => "https://github.com/maxsokolov/GoogleKit.git", :tag => "0.3.1" }
  s.source_files          = "GoogleKit"
  s.framework             = 'Foundation', 'UIKit', 'CoreLocation'
  s.requires_arc          = true
end