//
//  ZFLeakMonitorManager.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "ZFLeakMonitorManager.h"
#import "FloatView.h"

@interface ZFLeakMonitorManager()
@property (nonatomic, strong) NSMutableArray *leakViewControllersArr;//泄漏的viewController数组
@property (nonatomic, strong) NSMutableSet *whiteListSet;//需要被拦截的白名单（eg：navigationController，tabbarController）

@end

@implementation ZFLeakMonitorManager
+ (instancetype)sharedInstance{
    
    static ZFLeakMonitorManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[ZFLeakMonitorManager alloc] init];
    });
    return instance;
}
- (void)start{
    
    [self.leakViewControllersArr removeAllObjects];
    [self show];
}
- (void)addItems:(id)item{
    
    if ([self.whiteListSet containsObject:item]) {//白名单
        return ;
    }
    [self.leakViewControllersArr addObject:item];
}
- (NSMutableArray *)getItems{
    
    return self.leakViewControllersArr;
}
- (void)show{
    
    [[FloatView instance] show];
}
- (void)unShow{}

#pragma mark - Setter && Getter
- (NSMutableArray *)leakViewControllersArr{
    
    if (!_leakViewControllersArr) {
        
        _leakViewControllersArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _leakViewControllersArr;
}
- (NSMutableSet *)whiteListSet{
    
    if (!_whiteListSet) {
        
        _whiteListSet = [NSMutableSet set];
    }
    return _whiteListSet;
}

@end
