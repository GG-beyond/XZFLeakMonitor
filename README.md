# XZFLeakMonitor
监听viewController内存泄漏，内存泄漏，pop，dismiss


使用简单
	#ifdef DEBUG
		[[ZFLeakMonitorManager sharedInstance] start];
	#else

	#endif
	1、建议大家在DEBUG模式下开启
	2、功能先暂时实现，后续会完善，会加入pods库。
	3、大家多多提出意见。