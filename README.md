# XZFLeakMonitor
监听viewController内存泄漏，内存泄漏，pop，dismiss


使用简单

	#ifdef DEBUG 
	
		[[ZFLeakMonitorManager sharedInstance] startWithMonitorView:NO];//是否默认展示监控圆View（NO=默认不展示）
		
	#else


	#endif
	
	1、建议大家在DEBUG模式下开启
	2、功能先暂时实现，后续会完善，会加入pods库。
	3、大家多多提出意见。
	
	
	
	项目中的demo，   Two、FourViewController内有block互相引用导致内存泄漏。当页面消失时(pop or dismiss)，会去检测内存泄漏。