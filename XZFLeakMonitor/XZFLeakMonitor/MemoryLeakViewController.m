//
//  MemoryLeakViewController.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "MemoryLeakViewController.h"

@interface MemoryLeakViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *leakTableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation MemoryLeakViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.leakTableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}
#pragma mark - Setter && Getter
- (UITableView *)leakTableView{
    
    if (!_leakTableView) {
        
        _leakTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _leakTableView.dataSource = self;
        _leakTableView.delegate = self;
    }
    return _leakTableView;
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
