//
//  UINavigationController+LeakMonitor.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "UINavigationController+LeakMonitor.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

extern const char isDidPopKey;
@implementation UINavigationController (LeakMonitor)
+ (void)load{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstanceMethodSwizzlingWithOriginMethod:@selector(popViewControllerAnimated:) withSwizzledMethod:@selector(zf_popViewControllerAnimated:)];
        
        [self exchangeInstanceMethodSwizzlingWithOriginMethod:@selector(popToViewController:animated:) withSwizzledMethod:@selector(zf_popToViewController:animated:)];
        
        [self exchangeInstanceMethodSwizzlingWithOriginMethod:@selector(popToRootViewControllerAnimated:) withSwizzledMethod:@selector(zf_popToRootViewControllerAnimated:)];
    });
}
//pop一次
- (UIViewController *)zf_popViewControllerAnimated:(BOOL)animated{
    
    
    UIViewController *vc = [self zf_popViewControllerAnimated:animated];
    objc_setAssociatedObject(vc, &isDidPopKey, @(YES), OBJC_ASSOCIATION_ASSIGN);
    return vc;
}
//返回指定vc
- (NSArray<__kindof UIViewController *> *)zf_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSArray<__kindof UIViewController *> *arr = [self zf_popToViewController:viewController animated:animated];
    
    for (UIViewController *vc in arr) {
        
        objc_setAssociatedObject(vc, &isDidPopKey, @(YES), OBJC_ASSOCIATION_ASSIGN);
        [vc didDealloc];
    }
    return arr;
}
//返回root
- (NSArray<__kindof UIViewController *> *)zf_popToRootViewControllerAnimated:(BOOL)animated{
    
    NSArray<__kindof UIViewController *> *arr = [self zf_popToRootViewControllerAnimated:animated];
    for (UIViewController *vc in arr) {
        
        objc_setAssociatedObject(vc, &isDidPopKey, @(YES), OBJC_ASSOCIATION_ASSIGN);
        [vc didDealloc];
    }
    return arr;
}

@end
