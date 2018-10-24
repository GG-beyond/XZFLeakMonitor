//
//  TwoViewController.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface TwoViewController ()
@property (nonatomic, strong) UIButton *twoButton;
@property (nonatomic, copy) void (^mblock)(NSString *str);
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.twoButton];

    self.mblock = ^(NSString *str){
        
        NSLog(@"%@",self);
    };
}
- (UIButton *)twoButton{
    
    if (!_twoButton) {
        
        _twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_twoButton setTitle:@"Two" forState:UIControlStateNormal];
        _twoButton.frame = CGRectMake(150, 200, 100, 100);
        [_twoButton setBackgroundColor:[UIColor purpleColor]];
        [_twoButton addTarget:self action:@selector(doClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twoButton;
}
- (void)doClick{
    
    ThreeViewController *vc = [[ThreeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)dealloc{
    NSLog(@"two");
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
