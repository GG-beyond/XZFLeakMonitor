//
//  FloatView.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/25.
//  Copyright © 2018年 58. All rights reserved.
//

#import "FloatView.h"
#import "CircleView.h"
#import "MemoryLeakViewController.h"

const NSInteger FloatCicleWidth = 60.0f;
@interface FloatView ()

@property (nonatomic, strong) UIImageView *leakImageView;
@end
static CGPoint startPoint;
static CGPoint lastPoint;

@implementation FloatView

+ (instancetype)instance{
    
    static FloatView *leakView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        leakView = [[FloatView alloc] init];
    });
    return leakView;
}
- (void)show{
    
    UIView *superView = [self superview];
    if (!superView) {
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    }
    [self adjustToOriginLocation];
}
- (void)adjustToOriginLocation{
    
    UIView *superView = [self superview];
    if (superView) {
        
        self.frame = CGRectMake(CGRectGetMaxX(superView.frame)-FloatCicleWidth-10,superView.center.y , FloatCicleWidth, FloatCicleWidth);
        [self addSubview:self.leakImageView];
    }
}
#pragma mark - Touch method
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    startPoint = [touch locationInView:self];
    lastPoint = [touch locationInView:self.superview];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    
    self.center = CGPointMake(startPoint.x + point.x, startPoint.y + point.y);

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint currentPoint = [[touches anyObject] locationInView:self.superview];
    
    CGFloat centerX = self.center.x;
    CGFloat centerY = self.center.y;

    CGFloat minWidth = FloatCicleWidth/2.0+15;
    CGFloat maxXWidth = CGRectGetMaxX(self.superview.frame)-FloatCicleWidth/2.0-15;
    CGFloat maxYWidth = CGRectGetMaxY(self.superview.frame)-FloatCicleWidth/2.0-15;

    if (centerX<=minWidth) {
        centerX = minWidth;
    }else if (centerX>=maxXWidth) {
        centerX = maxXWidth;
    }
    if (centerY<=minWidth) {
        centerY = minWidth;
    }else if (centerY>=maxYWidth){
        centerY = maxYWidth;
    }
    self.center = CGPointMake(centerX, centerY);

    
    if (CGPointEqualToPoint(lastPoint, currentPoint)) {
        //点击
        NSLog(@"点击了");
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        if (![rootVC isKindOfClass:[UINavigationController class]]) {
            NSLog(@"根控制器不是 UINavigationController");
            return;
        }
        MemoryLeakViewController *vc = [[MemoryLeakViewController alloc] init];
        UINavigationController *navi = (UINavigationController *)rootVC;
        [navi pushViewController:vc animated:YES];

    }
    
}
#pragma mark -Setter
- (UIImageView *)leakImageView{
    
    if (!_leakImageView) {
        
        _leakImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _leakImageView.image = [UIImage imageNamed:@"leaks.jpg"];
        _leakImageView.backgroundColor = [UIColor redColor];
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_leakImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:_leakImageView.bounds.size];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bezierPath.CGPath;
        _leakImageView.layer.mask = shapeLayer;
    }
    return _leakImageView;
}

@end
