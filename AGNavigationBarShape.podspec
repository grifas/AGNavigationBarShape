#
# Be sure to run `pod lib lint AGNavigationBarShape.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AGNavigationBarShape"
  s.version          = "0.2.1"
  s.summary          = "AGNavigationBarShape is a custom navigation bar with severals shapes."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
AGNavigationBarShape allows you to custom the navigation bar with severals shapes availables.
                       DESC

  s.homepage         = "https://github.com/grifas/AGNavigationBarShape"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Aurelien Grifasi" => "aurelien.grifasi@gmail.com" }
  s.source           = { :git => "https://github.com/grifas/AGNavigationBarShape.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AGNavigationBarShape/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AGNavigationBarShape' => ['AGNavigationBarShape/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
