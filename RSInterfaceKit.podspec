#
# Be sure to run `pod lib lint RSInterfaceKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RSInterfaceKit"
  s.version          = "0.0.73"
  s.summary          = "RSInterfaceKit provides common UI components for iOS Development"
  s.description      = "RSInterfaceKit provides common UI components for iOS Development."
  s.homepage         = "https://github.com/raostudios/RSInterfaceKit"
  s.license          = 'MIT'
  s.author           = { "Venkat Rao" => "vrao423@gmail.com" }
  s.source           = { :git => "https://github.com/raostudios/RSInterfaceKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/venkatrao'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.frameworks = 'UIKit'

  s.subspec 'LoadingView' do |sdkit|
    sdkit.source_files = 'Pod/Classes/LoadingView/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/LoadingView/*.h'
    sdkit.dependency 'RSInterfaceKit/AutoLayoutHelpers'
  end

  s.subspec 'Alerts' do |sdkit|
    sdkit.source_files = 'Pod/Classes/Alerts/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/Alerts/*.h'
    sdkit.resources = 'Pod/Assets/Alerts/*.png'
    sdkit.dependency 'RSInterfaceKit/AutoLayoutHelpers'
    sdkit.resource_bundle = { 'RSInterfaceKit' => 'Pod/Assets/Alerts/*.png' }
  end

  s.subspec 'FullScreenImageView' do |sdkit|
    sdkit.source_files = 'Pod/Classes/FullScreenImageView/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/FullScreenImageView/*.h'
    sdkit.dependency 'RSInterfaceKit/ZoomableImageView'
  end

  s.subspec 'ZoomableImageView' do |sdkit|
    sdkit.source_files = 'Pod/Classes/ZoomableImageView/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/ZoomableImageView/*.h'
  end

  s.subspec 'RSSettings' do |sdkit|
    sdkit.source_files = 'Pod/Classes/RSSettings/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/RSSettings/*.h'
    sdkit.dependency 'RSInterfaceKit/AutoLayoutHelpers'
    sdkit.resources = 'Pod/Assets/RSSettings/*.png'
    sdkit.resource_bundle = { 'RSInterfaceKit_RSSettings' => 'Pod/Assets/RSSettings/*.png' }
  end

  s.subspec 'RSCarouselDissolvingImageView' do |sdkit|
    sdkit.source_files = 'Pod/Classes/RSCarouselDissolvingImageView/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/RSCarouselDissolvingImageView/*.h'
  end

  s.subspec 'RSCarouselScrollView' do |sdkit|
    sdkit.source_files = 'Pod/Classes/RSCarouselScrollView/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/RSCarouselScrollView/*.h'
  end

  s.subspec 'AutoLayoutHelpers' do |sdkit|
    sdkit.source_files = 'Pod/Classes/AutoLayoutHelpers/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/AutoLayoutHelpers/*.h'
  end

  s.subspec 'PortraitOnlyNavigation' do |sdkit|
    sdkit.source_files = 'Pod/Classes/PortraitOnly/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/PortraitOnly/*.h'
  end

  s.subspec 'CollectionViewWithTransitions' do |sdkit|
    sdkit.source_files = 'Pod/Classes/CollectionViewWithTransitions/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/CollectionViewWithTransitions/*.h'
  end

  s.subspec 'PopUps' do |sdkit|
    sdkit.source_files = 'Pod/Classes/PopUps/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/PopUps/*.h'
  end

  s.subspec 'NavigationBarMenu' do |sdkit|
    sdkit.source_files = 'Pod/Classes/NavigationBarMenu/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/NavigationBarMenu/*.h'
    sdkit.resources = 'Pod/Assets/NavigationBarMenu/*.png'
    sdkit.resource_bundle = { 'RSInterfaceKit_NavigationBarMenu' => 'Pod/Assets/NavigationBarMenu/*.png' }
  end

end
