Pod::Spec.new do |s|

s.name         = "MTestB"
s.version      = "1.0.1"
s.summary      = "MTestB SDK."
s.description  = "MTestB SDK for iOS."

s.homepage     = "http://www.yunduoketang.com"
s.license      = "MIT"
s.author       = { 'dxj' => 'qq@163.com' }

s.platform     = :ios, "11.0"
s.ios.deployment_target = "11.0"


s.source       = { :git => 'https://github.com/dongMan/dxjRouter.git', :tag => s.version.to_s }

s.requires_arc = true
s.static_framework = true
s.swift_version = '5.0'
s.prefix_header_contents = <<-DESC
  
  DESC
  
s.pod_target_xcconfig = {
  "GCC_PREPROCESSOR_DEFINITIONS" => "$(inherited) MTestB_NAME=#{s.name} MTestB_VERSION=#{s.version}"
}

s.user_target_xcconfig = {
  "GCC_PREPROCESSOR_DEFINITIONS" => "PODMTestB=1",
  "OTHER_SWIFT_FLAGS" => "-D PODMTestB"
}

#MTestB组件
   s.subspec 'B' do |b|
   b.source_files = 'MTestB/B/*.{h,m,swift}',
   'MTestB/B/**/*.{h,m,swift}'
   
   b.resource =
   "MTestB/B/*.{xib}",
   "MTestB/B/**/*.{xib}"
   
   b.resource_bundles = {
       'MTestB' => [
           'MTestB/Assets.xcassets'
       ]
   }
   b.dependency 'MBasis'
   b.ios.framework  = 'UIKit'
   end
   
   end
