//
//  FiveViewController.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "FiveViewController.h"

@interface FiveViewController ()
@property (nonatomic, strong) UIButton *twoButton;

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.twoButton];
}
- (UIButton *)twoButton{
    
    if (!_twoButton) {
        
        _twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_twoButton setTitle:@"five" forState:UIControlStateNormal];
        _twoButton.frame = CGRectMake(120, 200, 100, 100);
        [_twoButton setBackgroundColor:[UIColor redColor]];
        [_twoButton addTarget:self action:@selector(doClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twoButton;
}
- (void)doClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
