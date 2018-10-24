//
//  NSObject+Swizzling.h
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)

/**
 进行实例方法交换

 @param originMethod 原始方法Sel
 @param swizzledMethod 新方法
 */
+ (void)exchangeInstanceMethodSwizzlingWithOriginMethod:(SEL)originMethod withSwizzledMethod:(SEL)swizzledMethod;

/**
 进行类方法交换

 @param originMethod 原始方法
 @param swizzledMethod 新方法
 */
+ (void)exchangeClassMethodSwizzlingWithOriginMethod:(SEL)originMethod withSwizzledMethod:(SEL)swizzledMethod;


- (void)didDealloc;
@end

NS_ASSUME_NONNULL_END
