//
//  NSObject+Swizzling.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
#import "ZFLeakMonitorManager.h"

@implementation NSObject (Swizzling)
+ (void)exchangeInstanceMethodSwizzlingWithOriginMethod:(SEL)originMethod withSwizzledMethod:(SEL)swizzledMethod{
    
    Class class = [self class];

    Method oriMethod = class_getInstanceMethod(class, originMethod);
    Method swiMethod = class_getInstanceMethod(class, swizzledMethod);

    BOOL isAddMethod = class_addMethod(class, originMethod, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    if (isAddMethod) {
        
        class_replaceMethod(class, swizzledMethod, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else{
        
        method_exchangeImplementations(oriMethod, swiMethod);
    }
}

+ (void)exchangeClassMethodSwizzlingWithOriginMethod:(SEL)originMethod withSwizzledMethod:(SEL)swizzledMethod{
    
}
- (void)didDealloc{
    
    
    __weak NSObject *weakObjc = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakObjc) {
            
            __strong typeof(weakObjc) strongObjc = weakObjc;
            [[ZFLeakMonitorManager sharedInstance] addItems:strongObjc];
        }
    });
}

@end
