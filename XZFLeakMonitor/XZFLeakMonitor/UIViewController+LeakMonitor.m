//
//  UIViewController+LeakMonitor.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "UIViewController+LeakMonitor.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

/**
 UIViewController 实现leak监听思路：
 
 1、通过method swizzling方式，监听vc的几个方法（viewWillAppear、viewDidDisappear）;
 2、在viewWillAppear 设置一个标识isDidPop = NO(是否已经pop),
 3、在navigationController的Pop方法里 将pop的vc->isDidPop=YES
 4、在viewDidDisappear 根据（isDidPop=YES时）去开启监听vc是否释放了；利用的是vc的weak指针，延迟1.0秒后，判断weak指针是否为nil
 
 Push和Present   Pop和Dismiss 同理
 */
const char isDidPopKey;
@implementation UIViewController (LeakMonitor)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstanceMethodSwizzlingWithOriginMethod:@selector(viewWillAppear:) withSwizzledMethod:@selector(zf_viewWillAppear:)];
        
        [self exchangeInstanceMethodSwizzlingWithOriginMethod:@selector(viewDidDisappear:) withSwizzledMethod:@selector(zf_viewDidDisappear:)];
        
        [self exchangeInstanceMethodSwizzlingWithOriginMethod:@selector(dismissViewControllerAnimated:completion:) withSwizzledMethod:@selector(zf_dismissViewControllerAnimated:completion:)];
    });
    
}
//VC即将出现
- (void)zf_viewWillAppear:(BOOL)animation{
    

    [self zf_viewWillAppear:animation];
    self.isDidPop = NO;
}
//VC已经消失
- (void)zf_viewDidDisappear:(BOOL)animation{

    [self zf_viewDidDisappear:animation];
    if (self.isDidPop) {
        [self didDealloc];

    }
}
//Dismiss
- (void)zf_dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion{

    [self zf_dismissViewControllerAnimated:flag completion:completion];
    
    UIViewController *dismissVc = self.parentViewController;
    NSArray *childsArr = dismissVc.childViewControllers;
    if (childsArr.count>0) {
        for (UIViewController *vc in childsArr) {
            
            objc_setAssociatedObject(vc, &isDidPopKey, @(YES), OBJC_ASSOCIATION_ASSIGN);
            [vc didDealloc];
        }
    }else{
        
        objc_setAssociatedObject(self, &isDidPopKey, @(YES), OBJC_ASSOCIATION_ASSIGN);
    }
}
#pragma mark - Setter && Getter方法
- (void)setIsDidPop:(BOOL)isDidPop{
    
    objc_setAssociatedObject(self, &isDidPopKey, @(isDidPop), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isDidPop{
    
    return [objc_getAssociatedObject(self, &isDidPopKey) boolValue];
}
@end
