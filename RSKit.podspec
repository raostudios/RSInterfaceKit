#
# Be sure to run `pod lib lint RSKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RSKit"
  s.version          = "0.1.0"
  s.summary          = "RSKit provides common UI components for iOS Development"
  s.description      = "RSKit provides common UI components for iOS Development."
  s.homepage         = "https://github.com/raostudios/RSKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Venkat Rao" => "vrao423@gmail.com" }
  s.source           = { :git => "https://github.com/raostudios/RSKit.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/venkatrao'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.resource_bundles = {
    'RSKit' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'

  s.subspec 'LoadingView' do |sdkit|
    sdkit.source_files = 'Pod/Classes/LoadingView/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/LoadingView/*.h'
  end

  s.subspec 'Alerts' do |sdkit|
    sdkit.source_files = 'Pod/Classes/Alerts/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/Alerts/*.h'
  end

  s.subspec 'FullScreenImageView' do |sdkit|
    sdkit.source_files = 'Pod/Classes/FullScreenImageView/*.{h,m}'
    sdkit.public_header_files = 'Pod/Classes/FullScreenImageView/*.h'
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
end
