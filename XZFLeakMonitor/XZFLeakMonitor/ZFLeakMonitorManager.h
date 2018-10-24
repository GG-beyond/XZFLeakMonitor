//
//  ZFLeakMonitorManager.h
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFLeakMonitorManager : NSObject

+ (instancetype)sharedInstance;
- (void)start;
- (void)addItems:(id)item;
- (NSArray *)getItems;
- (void)show;
- (void)unShow;

@end

NS_ASSUME_NONNULL_END
