
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
  
  s.public_header_files = 'Pod/Classes/*.h'
  s.source_files        = 'Pod/Classes'
  
end
