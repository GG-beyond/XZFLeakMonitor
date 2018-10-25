//
//  FloatView.h
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/25.
//  Copyright © 2018年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FloatView : UIView
+ (instancetype)instance;

- (void)show;
- (void)unShow;
- (void)reShow;

- (void)badgeNumber:(NSInteger)number;
@end

NS_ASSUME_NONNULL_END
