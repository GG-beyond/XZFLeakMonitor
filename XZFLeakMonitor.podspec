

Pod::Spec.new do |s|


  s.name         = "XZFLeakMonitor"
  s.version      = "0.0.4"
  s.summary      = "A short description of XZFLeakMonitor.akdjfhajkdfhajdf "

  s.description  = <<-DESC
	检测UIviewcontroller 内存泄漏问题 pop dismiss是，dealloc检测问题，利用viewcontroller生命周期函数
                   DESC

  s.homepage     = "https://github.com/GG-beyond/XZFLeakMonitor"


  s.license      = "MIT ()"

  s.author             = { "GG-beyond" => "872608550@qq.com" }

   s.platform     = :ios, "8.0"


  s.source       = { :git => "https://github.com/GG-beyond/XZFLeakMonitor.git", :tag => "0.0.2" }




  s.source_files  = "XZFLeakMonitor/XZFLeakMonitor/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
