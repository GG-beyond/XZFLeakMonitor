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
@property (nonatomic, strong) UILabel *leakLabel;

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
    //展示
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
        [self addSubview:self.leakLabel];
    }
}
- (void)reShow{
    //重新展示
    self.hidden = NO;
}
- (void)unShow{
    //不展示
    self.hidden = YES;
}

- (void)badgeNumber:(NSInteger)number{
    
    if (number>0) {
        
        self.hidden = NO;
        self.leakLabel.hidden = NO;
        self.leakLabel.text = [NSString stringWithFormat:@"%ld",number];
    }else{
        
        self.leakLabel.hidden = YES;
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
    CGPoint currentPosition = [touch locationInView:self];
    //偏移量
    float offsetX = currentPosition.x - startPoint.x;
    float offsetY = currentPosition.y - startPoint.y;
    
    
    CGFloat minWidth = FloatCicleWidth/2.0;

    CGFloat centerX = self.center.x + offsetX;
    CGFloat centerY = self.center.y + offsetY;
    
    CGFloat maxXWidth = CGRectGetMaxX(self.superview.frame)-FloatCicleWidth/2.0;
    CGFloat maxYWidth = CGRectGetMaxY(self.superview.frame)-FloatCicleWidth/2.0;

    //判断x极限值
    if (centerX<=minWidth) {
        centerX = minWidth;
    }else if (centerX>=maxXWidth) {
        centerX = maxXWidth;
    }
    //判断y极限值
    if (centerY<=minWidth) {
        centerY = minWidth;
    }else if (centerY>=maxYWidth){
        centerY = maxYWidth;
    }


    self.center = CGPointMake(centerX,centerY );
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint currentPoint = [[touches anyObject] locationInView:self.superview];
    
    CGFloat centerX = self.center.x;
    CGFloat centerY = self.center.y;

    CGFloat minWidth = FloatCicleWidth/2.0;
    
    CGFloat superWidth = CGRectGetMaxX(self.superview.frame);
    CGFloat superHeight = CGRectGetMaxY(self.superview.frame);

    if (centerX<superWidth/2.0) {
        
        centerX = minWidth+10;
    }else{
        
        centerX = superWidth - minWidth - 10;
    }

    if (centerY<=minWidth+10) {
        
        centerY = minWidth+10;
    }else if (centerY >=superHeight-minWidth - 10){
        centerY = superHeight - minWidth - 10;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.center = CGPointMake(centerX, centerY);
    }];
    
    if (CGPointEqualToPoint(lastPoint, currentPoint)) {

        NSLog(@"点击了leak");
        //使用push
        [self pushToTargetViewController];
        //使用模态
//        [self presentToTargetViewController];
    }
}

#pragma mark - Private Methods
//使用push
- (void)pushToTargetViewController{
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navi;
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        
        navi = (UINavigationController *)rootVC;
    }else if (rootVC.navigationController){
        
        navi = rootVC.navigationController;
    }else if ([rootVC isKindOfClass:[UITabBarController class]]){
        
        for (UIViewController *vc in rootVC.childViewControllers) {
            
            if ([vc isKindOfClass:[UINavigationController class]]) {
                navi = (UINavigationController *)vc;
                break;
            }else{
                NSLog(@"vc不是 无法push");
            }
        }
        if (!navi) {//没有nav，没法push
            NSLog(@"vc不是 无法push");
            return;
        }
    }else{
        NSLog(@"vc不是 无法push");
        return;
    }
    MemoryLeakViewController *vc = [[MemoryLeakViewController alloc] init];
    [navi pushViewController:vc animated:YES];
    [self unShow];
}
//可以使用模态
- (void)presentToTargetViewController{
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    MemoryLeakViewController *vc = [[MemoryLeakViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [rootVC presentViewController:nav animated:YES completion:nil];
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
- (UILabel *)leakLabel{
    
    if (!_leakLabel) {
        
        _leakLabel = [[UILabel alloc] initWithFrame:CGRectMake(FloatCicleWidth-21, 1, 20, 20)];
        _leakLabel.backgroundColor = [UIColor redColor];
        _leakLabel.font = [UIFont systemFontOfSize:14];
        _leakLabel.layer.cornerRadius = 10;
        _leakLabel.layer.masksToBounds = YES;
        _leakLabel.hidden = YES;
        _leakLabel.textAlignment = NSTextAlignmentCenter;
        _leakLabel.textColor = [UIColor whiteColor];
    }
    return _leakLabel;
}
@end
