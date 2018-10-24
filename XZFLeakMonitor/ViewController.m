//
//  ViewController.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "XZFLeakMonitor/ZFLeakMonitorManager.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *topButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topButton];
    [[ZFLeakMonitorManager sharedInstance] start];
}
- (UIButton *)topButton{
    
    if (!_topButton) {
        
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topButton setTitle:@"Top" forState:UIControlStateNormal];
        _topButton.frame = CGRectMake(100, 200, 100, 100);
        [_topButton setBackgroundColor:[UIColor blueColor]];
        [_topButton addTarget:self action:@selector(doClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topButton;
}
- (void)doClick{
    
    OneViewController *vc = [[OneViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSArray *arr = [[ZFLeakMonitorManager sharedInstance] getItems];
    NSLog(@"arr = %@",arr);
}

@end
