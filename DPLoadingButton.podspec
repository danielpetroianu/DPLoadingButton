
Pod::Spec.new do |s|
  s.name                = "DPLoadingButton"
  s.version             = "0.1.0"
  s.license             = 'MIT'
  s.summary             = " A 'button like' control that displayes a UIActivityIndicatorView when the button fires a control event."
  s.description         = <<-DESC
                          DPLoadingButton is a button like control, that will display an animating UIActivityIndicatorView automatically until the button action is done.
                          DESC
  s.homepage            = "https://github.com/danielpetroianu/DPLoadingButton"
  s.authors             = { "Petroianu Daniel" => "petroianudaniel@gmail.com" }
  s.social_media_url    = 'https://twitter.com/danielpetroianu'
  s.screenshots         = "https://raw.githubusercontent.com/danielpetroianu/DPLoadingButton/master/Example/Screenshots/DPLoadingButton.gif"
  
  s.source              = { :git => "https://github.com/danielpetroianu/DPLoadingButton.git", :tag => s.version.to_s }
  s.platform            = :ios, '6.0'
  s.requires_arc        = true
  s.frameworks          = 'UIKit'
  



  #
  # DPLoadingButton/Core

  s.subspec 'Core' do |ss|
    ss.public_header_files = 'Pod/Classes/Core/*.h'
    ss.source_files        = 'Pod/Classes/Core'
  end


  # 
  # DPLoadingButton/AFNetworking

  s.subspec 'AFNetworking' do |ss|
    ss.dependency 'DPLoadingButton/Core'
    ss.dependency 'AFNetworking', '~> 2.3.1'

    ss.public_header_files  = 'Pod/Classes/AFNetworking/*.h'
    ss.source_files         = 'Pod/Classes/AFNetworking'
  end
  
end
