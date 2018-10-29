//
//  ThreeViewController.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "ThreeViewController.h"
#import "FourViewController.h"

@interface ThreeViewController ()
@property (nonatomic, strong) UIButton *twoButton;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.twoButton];
    // Do any additional setup after loading the view.
}
- (UIButton *)twoButton{
    
    if (!_twoButton) {
        
        _twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_twoButton setTitle:@"Three" forState:UIControlStateNormal];
        _twoButton.frame = CGRectMake(150, 200, 100, 100);
        [_twoButton setBackgroundColor:[UIColor orangeColor]];
        [_twoButton addTarget:self action:@selector(doClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twoButton;
}
- (void)doClick{
    
    FourViewController *four = [[FourViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:four];
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
    return;
    [self.navigationController popToRootViewControllerAnimated:YES];
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
