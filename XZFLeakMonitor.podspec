

Pod::Spec.new do |s|


  s.name         = "XZFLeakMonitor"
  s.version      = "0.0.1"
  s.summary      = "A short description of XZFLeakMonitor.akdjfhajkdfhajdf "

  s.description  = <<-DESC
	检测UIviewcontroller 内存泄漏问题
                   DESC

  s.homepage     = "https://github.com/GG-beyond/XZFLeakMonitor"


  s.license      = "MIT ()"

  s.author             = { "GG-beyond" => "872608550@qq.com" }

   s.platform     = :ios, "8.0"


  s.source       = { :git => "https://github.com/GG-beyond/XZFLeakMonitor.git", :tag => "0.0.1" }




  s.source_files  = "XZFLeakMonitor", "XZFLeakMonitor/XZFLeakMonitor/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
