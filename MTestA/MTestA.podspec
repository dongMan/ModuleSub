
Pod::Spec.new do |s|

s.name         = "MTestA"
s.version      = "1.0.1"
s.summary      = "MTestA SDK."
s.description  = "MTestA SDK for iOS."

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
  "GCC_PREPROCESSOR_DEFINITIONS" => "$(inherited) MTestA_NAME=#{s.name} MTestA_VERSION=#{s.version}"
}

#MTestA组件
 s.subspec 'A' do |a|
 a.source_files = 'MTestA/A/*.{h,m,swift}',
 'MTestA/A/**/*.{h,m,swift}',
 'MTestA/A/**/**/*.{h,m,swift}'
 
 a.resource =
 "MTestA/A/*.{xib}",
 "MTestA/A/**/*.{xib}",
 "MTestA/A/**/**/*.{xib}"
 
 a.resource_bundles = {
   'MTestA' => [
       'MTestA/Assets.xcassets'
   ]
 }
 
 a.user_target_xcconfig = {
   "GCC_PREPROCESSOR_DEFINITIONS" => "PODMTestA=1",
   "OTHER_SWIFT_FLAGS" => "-D PODMTestA"
 }
 
 #a.prefix_header_file = 'MTestA/A/MTestA.pch'

 a.dependency 'MBasis'

 a.ios.framework  = 'UIKit'
 end

end

