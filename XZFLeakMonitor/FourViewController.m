//
//  FourViewController.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "FourViewController.h"
#import "FiveViewController.h"

@interface FourViewController ()
@property (nonatomic, strong) UIButton *twoButton;
@property (nonatomic, copy) void (^mblock)(NSString *str);

@end

@implementation FourViewController

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
        [_twoButton setTitle:@"Four" forState:UIControlStateNormal];
        _twoButton.frame = CGRectMake(120, 200, 100, 100);
        [_twoButton setBackgroundColor:[UIColor orangeColor]];
        [_twoButton addTarget:self action:@selector(doClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twoButton;
}
- (void)doClick{
    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    return;
    FiveViewController *vc = [[FiveViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)dealloc{
    NSLog(@"four");
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
