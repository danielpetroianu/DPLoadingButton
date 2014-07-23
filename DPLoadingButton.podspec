#
# Be sure to run `pod lib lint DPLoadingButton.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                = "DPLoadingButton"
  s.version             = "0.1.0"
  s.license             = 'MIT'
  s.summary             = "Button like control with UIActivityIndicatorView as subview"
  s.description         = <<-DESC
                          DPLoadingButton is a button like control, that will display an UIActivityIndicatorView until the action is over
                          DESC
  s.homepage            = "https://github.com/danielpetroianu/DPLoadingButton"
  s.authors             = { "Petroianu Daniel" => "petroianudaniel@gmail.com" }
  s.social_media_url    = 'https://twitter.com/danielpetroianu'
  s.screenshots         = "https://raw.githubusercontent.com/danielpetroianu/DPLoadingButton/master/Example/Screenshots/DPLoadingButton.gif"

  s.platform            = :ios, '6.0'
  s.requires_arc        = true
  s.source              = { :git => "https://github.com/danielpetroianu/DPLoadingButton.git", :tag => s.version.to_s }

  s.frameworks          = 'UIKit'
  
  s.public_header_files = 'Pod/Classes/DPLoadingButton.h'
  s.source_files        = 'Pod/Classes/DPLoadingButton.m'
  
  s.subspec 'UIKit' do |ss|

    ss.ios.public_header_files  = 'Pod/Classes/DPLoadingButton+UIKit.h'
    ss.ios.source_files         = 'Pod/Classes/DPLoadingButton+UIKit.m'

  end
end
