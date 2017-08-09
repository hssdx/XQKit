Pod::Spec.new do |s|
  s.name         = "XQKit"
  s.version      = "1.4"
  s.summary      = "XQKit is useful kit."

  s.description  = <<-DESC
                      XQKit is Some commonly used tools are packaged to facilitate rapid integration of projects.
                   DESC

  s.homepage     = "https://github.com/hssdx/XQKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "hssdx" => "hssdx@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/hssdx/XQKit.git", :tag => s.version }

  s.source_files  = "XQKit/XQKit.h", "XQCategories/*.{h,m}", "XQCategories/**/*.{h,m}", "XQUIKit/*.{h,m}", "XQUIKit/**/*.{h,m}", "XQUtils/*.{h,m}", "XQUtils/**/*.{h,m}"

  s.public_header_files = "XQKit/XQKit.h", "XQCategories/*.{h}", "XQCategories/**/*.{h}", "XQUIKit/*.{h}", "XQUIKit/**/*.{h}", "XQUtils/*.{h}", "XQUtils/**/*.{h}"


  s.frameworks = "CoreFoundation", "UIKit"
  #s.framework  = "UIKit" 

  # s.library   = "iconv" 
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # , :git => 'https://github.com/ibireme/YYKit.git' 
  s.dependency "YYKit"
  s.dependency "MBProgressHUD"
  s.dependency "Masonry"

end
