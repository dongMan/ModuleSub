Pod::Spec.new do |s|

s.name         = "MTestC"
s.version      = "1.0.1"
s.summary      = "MTestC SDK."
s.description  = "MTestC SDK for iOS."

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
"GCC_PREPROCESSOR_DEFINITIONS" => "$(inherited) MTestC_NAME=#{s.name} MTestC_VERSION=#{s.version}"
}

s.user_target_xcconfig = {
  "GCC_PREPROCESSOR_DEFINITIONS" => "PODMTestC=1",
  "OTHER_SWIFT_FLAGS" => "-D PODMTestC"
}

#MTestC组件
s.subspec 'C' do |c|
c.source_files = 'MTestC/C/*.{h,m,swift}',
'MTestC/C/**/*.{h,m,swift}'

c.resource =
"MTestC/C/*.{xib}",
"MTestC/C/**/*.{xib}"

c.resource_bundles = {
'MTestC' => [
'MTestC/Assets.xcassets'
]
}
c.dependency 'MBasis'
c.ios.framework  = 'UIKit'
end


end
