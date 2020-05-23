Pod::Spec.new do |s|
  
  s.name         = "MBasis"
  s.version      = "1.0.0"
  s.summary      = "MBasis SDK."
  s.description  = "MBasis SDK for iOS."
  
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
    "GCC_PREPROCESSOR_DEFINITIONS" => "$(inherited) MBasis_NAME=#{s.name} MBasis_VERSION=#{s.version}"
  }
  
  
  #Basis组件
  s.subspec 'SubBasis' do |ss|
  
        ### Base
        ss.subspec "Base" do |sss|
          sss.source_files = ["Foundation/**/*.{h,m}", "UIKit/**/*.{h,m}"]
          sss.public_header_files = [ "Foundation/**/*.h", "UIKit/**/*.h"]
          sss.frameworks = ["Foundation", "UIKit"]
          sss.libraries = ['icucore', 'c++']
        end
        
        ### MBaseSDK
        ss.subspec "MBaseSDK" do |sss|
          sss.public_header_files =
          "MBaseSDK/**/*.h"
          
          sss.source_files =
          "MBaseSDK/*.{h,m,swift}",
          "MBaseSDK/**/*.{h,m,swift}"
          
          sss.frameworks = "OpenAL", "GLKit"
          sss.libraries = "iconv", "z", "sqlite3"
          
          sss.dependency 'FFToast', '1.2.0'
          sss.dependency 'MBProgressHUD'
          sss.dependency 'LKDBHelper', '2.5.1'
        end
    
        ### MConfig
        ss.subspec "MConfig" do |sss|
          sss.source_files  = "MConfig/*.swift"
        end
        
        ### Protocol
        ss.subspec "Protocol" do |sss|
          sss.source_files  = "Protocol/*.swift"
        end
        
        ### CTMediatorFile
        ss.subspec "CTMediatorFile" do |sss|
          sss.public_header_files = "CTMediatorFile/*.h"
          sss.source_files = "CTMediatorFile/*.{h,m,swift}"
          
          sss.dependency 'CTMediator'
        end
    
        ### MColor
        ss.subspec "MColor" do |sss|
          sss.source_files  = "MColor/*.swift"
        end
        
        ### Network
        ss.subspec "Network" do |sss|
          sss.public_header_files =
          "Network/**/*.h"
          
          sss.source_files =
          "Network/**/*.{h,m,swift}"
          
          ### 网络 解析
          sss.dependency 'AFNetworking'
          sss.dependency 'HandyJSON', '~> 5.0.0'
          sss.dependency 'Alamofire', '~> 4.8.2'
          
          ### socket
          sss.dependency 'Socket.IO-Client-Swift', '13.2.1'
          
          sss.dependency 'Reachability'
          sss.dependency 'MBaseSDK' #MBasis.podspec 下的MBasis 下的MBaseSDK
          
        end

        ### SSL
        ss.subspec "SSL" do |sss|
          sss.public_header_files = "SSL/*.h"
          sss.source_files = "SSL/*.{h,m}"
        end
    
  end
  s.dependency 'MGJRouter'

 # s.prefix_header_file = 'BaseSDK/MBasis.pch'

end
