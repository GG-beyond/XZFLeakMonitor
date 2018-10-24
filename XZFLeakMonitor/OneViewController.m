//
//  OneViewController.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"
@interface OneViewController ()

@property (nonatomic, strong) UIButton *oneButton;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.oneButton];
}
- (UIButton *)oneButton{
    
    if (!_oneButton) {
        
        _oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_oneButton setTitle:@"One" forState:UIControlStateNormal];
        _oneButton.frame = CGRectMake(120, 200, 100, 100);
        [_oneButton setBackgroundColor:[UIColor blueColor]];
        [_oneButton addTarget:self action:@selector(doClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _oneButton;
}
- (void)doClick{
    
    TwoViewController *vc = [[TwoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)dealloc{
    NSLog(@"one");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
